class CreateCourseRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :course_registrations do |t|

      t.timestamps
    end
  end
end
