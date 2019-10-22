class AddDepartmentToTeacher < ActiveRecord::Migration[6.0]
  def change
    add_reference :teachers, :department, foreign_key: true, null: false
  end
end
