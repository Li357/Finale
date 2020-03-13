class CreateTeacherFinalAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_final_assignments do |t|

      t.timestamps
    end

    add_reference :teacher_final_assignments, :teacher, foreign_key: { primary_key: :user_id }, null: false
    add_reference :teacher_final_assignments, :final, foreign_key: true, null: false
  end
end
