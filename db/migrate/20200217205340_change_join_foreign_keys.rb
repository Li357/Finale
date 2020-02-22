class ChangeJoinForeignKeys < ActiveRecord::Migration[6.0]
  def change
    remove_reference :department_assignments, :teacher, foreign_key: { primary_key: :user_id }
    add_reference :department_assignments, :teacher

    remove_reference :student_course_registrations, :student, foreign_key: { primary_key: :user_id }
    add_reference :student_course_registrations, :student

    remove_reference :teacher_course_registrations, :teacher, foreign_key: { primary_key: :user_id }
    add_reference :teacher_course_registrations, :teacher

    remove_reference :student_final_signups, :student, foreign_key: { primary_key: :user_id }
    add_reference :student_final_signups, :student

    remove_reference :teacher_final_assignments, :teacher, foreign_key: { primary_key: :user_id }
    add_reference :teacher_final_assignments, :teacher
  end
end
