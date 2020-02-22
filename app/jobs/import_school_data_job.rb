# frozen_string_literal: true

require "sequel"
require "tiny_tds"

# TODO: Fix symbols not working here...
STUDENT = 0
TEACHER = 1
ADMIN = 2

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

    begin
      puts "Importing students..."
      import_students
      puts "Importing departments..."
      import_departments
      puts "Importing teachers and admins..."
      import_teachers_and_admins
      puts "Importing courses..."
      import_courses
      puts "All done!"
    rescue Sequel::DatabaseError => error
      puts "Error: #{error}"
    end
    @DB.disconnect
  end

  def import_courses
    today = Date.today.strftime("%F")
    students_courses_query = <<~SQL
      SELECT
        Students.Id AS student_id,
        Courses.Id AS course_id,
        Courses.Name AS course_name,
        Courses.DepartmentId AS course_department
      FROM EnrollmentRecords ER
      INNER JOIN Courses ON ER.CourseId = Courses.Id
      INNER JOIN Semesters S ON ER.SemesterId = S.Id
      INNER JOIN Students ON ER.StudentId = Students.Id
      WHERE Students.[Deleted] = 0 AND S.StartDate <= ? AND ? <= S.EndDate
    SQL

    seen_courses = {}
    courses = []
    students_courses = []
    @DB[students_courses_query, today, today].each do |row|
      course_id = row[:course_id]
      if !seen_courses.key?(course_id) # The courses are inserted on a need-basis, only the courses with active students are inserted to save space
        courses << { id: course_id, name: row[:course_name], department_id: row[:course_department] }
        seen_courses[course_id] = 1
      end
      students_courses << { student_id: row[:student_id], course_id: row[:course_id] }
    end

    teachers_courses_query = <<~SQL
      SELECT DISTINCT Teachers.Id AS teacher_id, Courses.Id AS course_id
      FROM TeacherScheduledMeetings TSM
      INNER JOIN Teachers ON TSM.TeacherId = Teachers.Id
      INNER JOIN ScheduledMeetings SM ON TSM.ScheduledMeetingId = SM.Id
      INNER JOIN Courses ON SM.CourseId = Courses.Id
      INNER JOIN Semesters S on SM.SemesterId = S.Id
      WHERE Teachers.[Deleted] = 0 AND S.StartDate <= ? AND ? <= S.EndDate
    SQL

    teachers_courses = []
    @DB[teachers_courses_query, today, today].each do |row|
      if seen_courses.key?(row[:course_id]) # need to check if the course a teacher teaches is needed, i.e. are there students actually taking it?
        teachers_courses << { teacher_id: row[:teacher_id], course_id: row[:course_id] }
      end
    end

    Course.transaction do
      Course.insert_all(courses)
      StudentCourseRegistration.insert_all(students_courses)
      TeacherCourseRegistration.insert_all(teachers_courses)
    end
  end

  def import_students
    query = <<~SQL
      SELECT userid, username, studentid, firstname, middlename, lastname, suffix, profilepictureuri FROM (
        SELECT
          UserId,
          UserName,
          MAX(CASE WHEN [Type] LIKE '%Id' THEN [Value] END) AS StudentId,
          MAX(CASE WHEN [Value] = 'student' THEN 1 ELSE 0 END) AS Student
        FROM UserClaims
        INNER JOIN Users ON UserClaims.UserId = Users.Id
        WHERE [Type] LIKE '%Id' OR [Type] LIKE '%role'
        GROUP BY UserId, UserName
      ) src
      INNER JOIN Students ON Students.Id = StudentId
      WHERE Student = 1 AND Students.[Deleted] = 0;
    SQL

    users = []
    students = []
    roles = []

    @DB[query].each do |row|
      user_id = row[:userid]
      users << {
        id: user_id,
        username: row[:username],
        first_name: row[:firstname], middle_name: row[:middlename] || '', last_name: row[:lastname], suffix: row[:suffix] || '',
        profile_photo: row[:profilepictureuri],
      }
      roles << { user_id: user_id, role_type: STUDENT }
      students << { user_id: user_id, id: row[:studentid] }
    end

    Student.transaction do
      User.insert_all(users)
      Role.insert_all(roles)
      Student.insert_all(students)
    end
  end

  def import_departments
    departments = []

    @DB[:Departments]
      .select(:id, :name)
      .where(deleted: 0)
      .each do |department|
        departments << { id: department[:id], name: department[:name] }
      end

    Department.insert_all(departments)
  end

  def import_teachers_and_admins
    # User can either be one of teacher or admin or both
    # If a user is not a teacher but an admin, they still have a teacher id in the Teacher table with info
    teacher_query = <<~SQL
      SELECT userid, username, firstname, lastname, profilepictureuri, teacherid, departmentid, teacher, [admin] FROM (
        SELECT
          UserId,
          UserName,
          MAX(CASE WHEN [Type] LIKE '%Id' THEN [Value] END) AS TeacherId,
          MAX(CASE WHEN [Value] = 'teacher' THEN 1 ELSE 0 END) AS Teacher,
          MAX(CASE WHEN [Value] = 'admin' THEN 1 ELSE 0 END) AS [admin]
        FROM UserClaims
        INNER JOIN Users ON UserClaims.UserId = Users.Id
        WHERE [Type] LIKE '%Id' OR [Type] LIKE '%role'
        GROUP BY UserId, UserName
      ) src
      INNER JOIN Teachers ON Teachers.Id = TeacherId
      WHERE (Teacher = 1 OR [Admin] = 1) AND [Deleted] = 0;
    SQL

    users = []
    roles = []
    teachers = []
    department_assignments = []
    admins = []

    @DB[teacher_query].each do |row|
      user_id = row[:userid]
      teacher_id = row[:teacherid]
      users << {
        id: user_id,
        username: row[:username],
        first_name: row[:firstname], middle_name: "", last_name: row[:lastname], suffix: "",
        profile_photo: row[:profilepictureuri],
      }

      if row[:teacher]
        roles << { user_id: user_id, role_type: TEACHER }
        teachers << { id: teacher_id, user_id: user_id }
        # Association is Finale's Teacher ID --> School's Department ID
        department_assignments << { teacher_id: teacher_id, department_id: row[:departmentid] }
      end

      # Those exclusively admins do not have department info saved since they will never need to supervise finals
      if row[:admin]
        admins << { id: teacher_id, user_id: user_id }
        roles << { user_id: user_id, role_type: ADMIN }
      end
    end

    Teacher.transaction do
      User.insert_all(users)
      Role.insert_all(roles)
      Teacher.insert_all(teachers)
      DepartmentAssignment.insert_all(department_assignments)
      Admin.insert_all(admins)
    end
  end
end
