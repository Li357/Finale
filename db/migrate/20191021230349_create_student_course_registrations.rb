class CreateStudentCourseRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :student_course_registrations do |t|

      t.timestamps
    end
  end
end
