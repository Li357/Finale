class CreateStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :students, primary_key: :user_id do |t|

      t.timestamps
    end
  end
end
