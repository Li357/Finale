class CreateStudentsFinals < ActiveRecord::Migration[6.0]
  def change
    create_table :students_finals do |t|

      t.timestamps
    end
  end
end
