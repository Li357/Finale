class CreateFinalSignups < ActiveRecord::Migration[6.0]
  def change
    create_table :final_signups do |t|

      t.timestamps
    end
  end
end
