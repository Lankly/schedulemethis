class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :short_description
      t.string :description
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.integer :start_time_flex_amount
      t.integer :end_time_flex_amount
      t.integer :priority
      t.boolean :may_split
      t.integer :estimated_time_required
      t.string :location

      t.timestamps null: false
    end
  end
end
