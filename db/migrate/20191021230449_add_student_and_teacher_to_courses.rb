class AddStudentAndTeacherToCourses < ActiveRecord::Migration[6.0]
  def change
    add_reference :students_courses, :student, foreign_key: { primary_key: :user_id }, null: false
    add_reference :students_courses, :course, foreign_key: true, null: false

    add_reference :teachers_courses, :teacher, foreign_key: { primary_key: :user_id }, null: false
    add_reference :teachers_courses, :course, foreign_key: true, null: false
  end
end
