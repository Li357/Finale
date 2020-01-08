# frozen_string_literal: true

require "sequel"
require "tiny_tds"

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
    import_courses

    @DB.disconnect
  end

  def import_courses
    today = Date.today

    courses = []
    students_courses = []
    @DB[:EnrollmentRecords]
      .select(Sequel.lit(<<~SQL))
        Students.Id AS StudentId,
        Courses.Id AS CourseId,
        Courses.Name AS CourseName,
        Courses.DepartmentId AS CourseDepartment
      SQL
      .join(:Courses, Id: :CourseId)
      .join(:Semesters, Id: :SemesterId)
      .join(:Students, Id: :StudentId)
      .where(Sequel.lit("Students.[Deleted] = 0 AND StartDate <= ? AND ? <= EndDate", today))
      .each do |row|
        courses << Course.new(id: row[:CourseId], name: row[:CourseName], department_id: row[:CourseDepartment])
        students_courses << StudentCourseRegistration.new(student_id: row[:StudentId], course_id: row[:CourseId])
      end

    teachers_courses = []
    @DB[:TeacherScheduledMeetings]
      .select(Sequel.lit("DISTINCT Teachers.Id AS TeacherId, Courses.Id AS CourseId"))
      .join(:Teachers, Id: :TeacherId)
      .join(:ScheduledMeetings, Id: :ScheduledMeetingId)
      .join(:Semesters, Id: :SemesterId)
      .join(:Courses, Id: :CourseId)
      .where(Sequel.lit("Teachers.[Deleted] = 0 AND StartDate <= ? AND ? <= EndDate", today))
      .each do |row|
        teachers_courses << TeacherCourseRegistration.new(teacher_id: row[:TeacherId], course_id: row[:CourseId])
      end

    Course.transaction do
      Course.import(courses)
      StudentCourseRegistration.import(students_courses)
      TeacherCourseRegistration.import(teachers_courses)
    end
  end

  def import_students
    query = <<~SQL
      SELECT UserId, UserName, StudentId, FirstName, MiddleName, LastName, Suffix, ProfilePictureUri FROM (
        SELECT
          UserId,
          UserName,
          MAX(CASE WHEN [Type] LIKE "%Id" THEN [Value] END) AS StudentId,
          MAX(CASE WHEN [Value] = "student" THEN 1 ELSE 0 END) AS Student
        FROM UserClaims
        INNER JOIN Users ON UserClaims.UserId = Users.Id
        WHERE [Type] LIKE "%Id" OR [Type] LIKE "%role"
        GROUP BY UserId, UserName
      ) src
      INNER JOIN Students ON Students.Id = StudentId
      WHERE Student = 1 AND Students.[Deleted] = 0;
    SQL

    users = []
    students = []
    roles = []

    @DB[query].each do |row|
      user = User.new(
        id: row[:UserId],
        username: row[:UserName],
        first_name: row[:FirstName], middle_name: row[:MiddleName], last_name: row[:LastName], suffix: row[:Suffix],
        profile_photo: row[:ProfilePictureUri],
      )
      roles << Role.new(user: user, role_type: :student)
      students << Student.new(id: row[:StudentId], user: user)
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
      SELECT UserId, UserName, FirstName, LastName, ProfilePictureUri, TeacherId, DepartmentId, [Admin] FROM (
        SELECT
          UserId,
          UserName,
          MAX(CASE WHEN [Type] LIKE "%Id" THEN [Value] END) AS TeacherId,
          MAX(CASE WHEN [Value] = "teacher" THEN 1 ELSE 0 END) AS Teacher,
          MAX(CASE WHEN [Value] = "admin" THEN 1 ELSE 0) AS [Admin]
        FROM UserClaims
        INNER JOIN Users ON UserClaims.UserId = Users.Id
        WHERE [Type] LIKE "%Id" OR [Type] LIKE "%role"
        GROUP BY UserId, UserName
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
        id: row[:UserId],
        username: row[:UserName],
        first_name: row[:FirstName], middle_name: "", last_name: row[:LastName], suffix: "",
        profile_photo: row[:ProfilePictureUri],
      )

      if row[:Teacher]
        roles << Role.new(user: user, role_type: :teacher)
        teachers << Teacher.new(id: row[:TeacherId], user: user)
        # Association is Finale's Teacher ID --> School's Department ID
        department_assignments << DepartmentAssignment.new(teacher_id: row[:TeacherId], department_id: row[:DepartmentId])
      end

      # Those exclusively admins do not have department info saved since they will never need to supervise finals
      if row[:Admin]
        admins << Admin.new(id: row[:TeacherId], user: user)
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
