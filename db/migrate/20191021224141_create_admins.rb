class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins, primary_key: :user_id do |t|

      t.timestamps
    end
  end
end
