class AddDepartmentToCourses < ActiveRecord::Migration[6.0]
  def change
    add_reference :courses, :department, foreign_key: true, null: false
  end
end
