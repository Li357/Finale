class AddIdToUserTypes < ActiveRecord::Migration[6.0]
  def change
    # Each user type (student, teacher, admin) table has two ID columns, user_id and id
    # user_id -> Maps directly to school database's User table Id field (unique between all user types)
    # id -> Maps directly tp school database's Student/Teacher Id (not unique, i.e. one Student and one Teacher)
    #       may have the same ID. Used to associate student/teachers to courses/finals

    add_column :students, :id, :integer, null: false
    add_index :students, :id, unique: true
    add_column :teachers, :id, :integer, null: false
    add_index :teachers, :id, unique: true
    add_column :admins, :id, :integer, null: false
    add_index :admins, :id, unique: true
  end
end
