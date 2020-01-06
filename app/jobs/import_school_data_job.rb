require 'sequel'
require 'tiny_tds'

class ImportSchoolDataJob < ApplicationJob
  queue_as :urgent

  def perform(*args)
    credentials = Rails.application.credentials.whs_db
    db_conn_opts = {
      adapter: :tinytds,
      host: credentials[:host],
      database: credentials[:db],
      user: credentials[:username],
      password: credentials[:password],
      azure: true,
    }
    @DB = Sequel.connect(db_conn_opts)

    import_students
    import_departments
    import_teachers_and_admins

    @DB.disconnect
  end

  def import_courses
    # Get courses for students
    today = Date.today
    @DB[:EnrollmentRecords]
      .join(:Courses, Id: :CourseId)
      .join(:Semesters, Id: :SemesterId)
      .join(:Students, Id: :StudentId)
      .where{StartDate <= today && today <= EndDate}
      .each do |student|

      end

    # Get courses for teachers
    # @DB['
    #   select distinct T.FirstName, T.LastName, C.Name from TeacherScheduledMeetings TSM
    #   inner join Teachers T on T.Id = TSM.TeacherId
    #   inner join ScheduledMeetings SM on SM.Id = TSM.ScheduledMeetingId
    #   inner join Semesters S on S.Id = SM.SemesterId
    #   inner join Courses C on SM.CourseId = C.Id
    #   where C.Deleted = 0 and StartDate <= :current_date and EndDate >= '2019-12-20'  
    # ']
  end

  def import_students
    query = <<~SQL
      SELECT UserName, FirstName, MiddleName, LastName, Suffix, ProfilePictureUri FROM (
        SELECT 
          UserName,
          MAX(CASE WHEN [Type] like '%Id' then [Value] end) as StudentId,
          MAX(CASE WHEN [Value] = 'student' then 1 else 0 end) as Student
        FROM UserClaims
        INNER JOIN Users ON UserClaims.UserId = Users.Id
        WHERE Type LIKE '%Id' OR Type LIKE '%role'
        GROUP BY UserName
      ) src
      INNER JOIN Students ON Students.Id = StudentId
      WHERE Student = 1 and [Deleted] = 0;
    SQL

    users = []
    students = []
    roles = []

    @DB[query].each do |row|
      user = User.new(
        username: row[:UserName],
        first_name: row[:FirstName], middle_name: row[:MiddleName], last_name: row[:LastName], suffix: row[:Suffix],
        profile_photo: row[:ProfilePictureUri],
      )
      roles << Role.new(user: user, role_type: :student)
      students << Student.new(user: user)
      users << user
    end

    Student.transaction do
      User.import(users)
      Role.import(roles)
      Student.import(students)
    end
  end

  def import_departments
    departments = []

    @DB[:Departments]
      .select(:Id, :Name)
      .where(Deleted: 0)
      .each do |department|
        departments << Department.new(id: department[:Id], name: department[:Name])
      end

    Department.import(departments)
  end

  def import_teachers_and_admins
    # User can either be one of teacher or admin or both
    # If a user is not a teacher but an admin, they still have a teacher id in the Teacher table with info
    teacher_query = <<~SQL
      SELECT UserName, FirstName, LastName, ProfilePictureUri, Teacher, DepartmentId, [Admin] FROM (
        SELECT 
          UserName,
          MAX(CASE WHEN [Type] like '%Id' then [Value] end) as TeacherId,
          MAX(CASE WHEN [Value] = 'teacher' then 1 else 0 end) as Teacher,
          MAX(CASE WHEN [Value] = 'admin' then 1 else 0) as [Admin]
        FROM UserClaims
        INNER JOIN Users ON UserClaims.UserId = Users.Id
        WHERE [Type] LIKE '%Id' OR [Type] LIKE '%role'
        GROUP BY UserName
      ) src
      INNER JOIN Teachers ON Teachers.Id = TeacherId
      WHERE (Teacher = 1 or [Admin] = 1) and [Deleted] = 0;
    SQL

    users = []
    roles = []
    teachers = []
    department_assignments = []
    admins = []

    @DB[teacher_query].each do |row|
      user = User.new(
        username: row[:UserName],
        first_name: row[:FirstName], middle_name: '', last_name: row[:LastName], suffix: '',
        profile_photo: row[:ProfilePictureUri],
      )

      if row[:Teacher]
        teacher = Teacher.new(user: user)
        roles << Role.new(user: user, role_type: :teacher)
        teachers << teacher
        # Association is Finale's Teacher ID --> School's Department ID
        department_assignments << DepartmentAssignment.new(teacher_id: teacher[:Id], department_id: row[:DepartmentId])
      end

      # Those exclusively admins do not have department info saved since they will never need to supervise finals
      if row[:Admin]
        admins << Admin.new(user: user)
        roles << Role.new(user: user, role_type: :admin)
      end
      users << user
    end

    Teacher.transaction do
      User.import(users)
      Role.import(roles)
      Teacher.import(teachers)
      DepartmentAssignment.import(department_assignments)
      Admin.import(admins)
    end
  end
end
