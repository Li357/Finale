class RenameJoinTables < ActiveRecord::Migration[6.0]
  def change
    rename_table :students_courses, :student_course_registrations
    rename_table :teachers_courses, :teacher_course_registrations
    rename_table :teachers_departments, :department_assignments
    rename_table :students_finals, :student_final_signups
  end
end
