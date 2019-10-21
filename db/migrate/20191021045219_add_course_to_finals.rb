class AddCourseToFinals < ActiveRecord::Migration[6.0]
  def change
    add_reference :finals, :course, foreign_key: true, null: false
  end
end
