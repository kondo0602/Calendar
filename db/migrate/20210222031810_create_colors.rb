class CreateColors < ActiveRecord::Migration[6.0]
  def change
    create_table :colors do |t|
      t.string :color_name, null: false
      t.timestamps
    end
  end
end
