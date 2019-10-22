class CreateTeacherCourseRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_course_registrations do |t|

      t.timestamps
    end
  end
end
