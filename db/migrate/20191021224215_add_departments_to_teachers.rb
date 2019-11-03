class AddDepartmentsToTeachers < ActiveRecord::Migration[6.0]
  def change
    add_reference :teachers_departments, :teacher, foreign_key: { primary_key: :user_id }, null: false
    add_reference :teachers_departments, :department, foreign_key: true, null: false
  end
end
