class CreateMinutes < ActiveRecord::Migration[6.0]
  def change
    create_table :minutes do |t|
      t.string :minutes_per_15, null: false
      t.timestamps
    end
  end
end
