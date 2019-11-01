class CreateFinals < ActiveRecord::Migration[6.0]
  def change
    create_table :finals do |t|
      t.integer :mod
      t.integer :capacity
      t.string :room

      t.timestamps
    end

    create_table :finals_students do |t|
      
      t.timestamps
    end
  end
end
