class AddStudentAndFinalToFinalSignups < ActiveRecord::Migration[6.0]
  def change
    add_reference :students_finals, :student, foreign_key: { primary_key: :user_id }, null: false
    add_reference :students_finals, :final, foreign_key: true, null: false
  end
end
