class AddStudentAndFinalToSignups < ActiveRecord::Migration[6.0]
  def change
    add_reference :final_signups, :student, foreign_key: { primary_key: :user_id }, null: false
    add_reference :final_signups, :final, foreign_key: true, null: false
  end
end
