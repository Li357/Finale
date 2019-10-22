class AddStudentAndTeacherToRegistration < ActiveRecord::Migration[6.0]
  def change
    add_reference :student_course_registrations, :student, foreign_key: { to_table: :users }, null: false
    add_reference :student_course_registrations, :course, foreign_key: true, null: false

    add_reference :teacher_course_registrations, :teacher, foreign_key: { to_table: :users }, null: false
    add_reference :teacher_course_registrations, :course, foreign_key: true, null: false
  end
end
