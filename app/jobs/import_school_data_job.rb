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

    import_courses
    import_students
    import_teachers_and_departments
    # set_admins

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
    users = []
    roles = []
    students = []

    @DB[:Students]
      .select(:FirstName, :MiddleName, :LastName, :Suffix, :ProfilePictureUri)
      .where(Deleted: 0)
      .each do |student|
        user = User.new(
          username: 'TODO',
          first_name: student[:FirstName], middle_name: student[:MiddleName], last_name: student[:LastName], suffix: student[:Suffix],
          profile_photo: student[:profilepictureuri],
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

  def import_teachers_and_departments
    departments = []
    users = []
    roles = []
    teachers = []
    department_assignments = []

    @DB[:Departments]
      .select(:Id, :Name)
      .where(Deleted: 0)
      .each do |department|
        departments << Department.new(id: department[:Id], name: department[:Name])
      end

    @DB[:teachers]
      .select(:DepartmentId, :FirstName, :LastName, :ProfilePictureUri)
      .where(Deleted: 0)
      .each do |teacher|
        user = User.new(
          username: 'TODO',
          first_name: teacher[:firstname], middle_name: '', last_name: teacher[:lastname], suffix: '',
          profile_photo: teacher[:profilepictureuri],
        )
        teacher = Teacher.new(user: user)
        roles << Role.new(user: user, role_type: :teacher)
        teachers << teacher
        department_assignments << DepartmentAssignment.new(teacher_id: teacher[:Id], department_id: teacher[:DepartmentId])
        users << user
      end

    Teacher.transaction do
      User.import(users)
      Role.import(roles)
      Department.import(departments)
      Teacher.import(teachers)
      DepartmentAssignment.import(department_assignments)
    end
  end
end
