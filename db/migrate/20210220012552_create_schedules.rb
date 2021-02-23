class CreateSchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :schedules do |t|
      t.date :schedule_date, null: false
      t.integer :start_time_id, null: false
      t.integer :end_time_id, null: false
      t.string :title, null: false
      t.integer :color_id, default: 0
      t.timestamps
    end
  end
end
