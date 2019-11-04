class AddSignupIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :students_finals, [:student_id, :final_id], unique: true
  end
end
