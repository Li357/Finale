class AddTeacherToFinals < ActiveRecord::Migration[6.0]
  def change
    add_reference :finals, :teacher, foreign_key: { primary_key: :user_id }, null: false
  end
end
