class UpdateNullableFields < ActiveRecord::Migration[6.0]
  def change
    change_column_null :roles, :role_type, false
    change_column_null :departments, :name, false

    change_column_null :finals, :mod, false
    change_column_null :finals, :capacity, false
    change_column_null :finals, :room, false

    change_column_null :users, :username, false
    change_column_null :users, :first_name, false
    change_column_null :users, :middle_name, false, ''
    change_column_null :users, :last_name, false
    change_column_null :users, :suffix, false, ''
  end
end
