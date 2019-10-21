class AddUserAndCourseToCourseRegistrations < ActiveRecord::Migration[6.0]
  def change
    add_reference :course_registrations, :user, foreign_key: true, null: false
    add_reference :course_registrations, :course, foreign_key: true, null: false
  end
end
