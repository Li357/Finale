class AddRoleTypeToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :role, foreign_key: true, null: false
  end
end
