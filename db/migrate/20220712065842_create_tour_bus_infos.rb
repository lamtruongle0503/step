class CreateTourBusInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_bus_infos do |t|
      t.references :tour, null: false, foreign_key: true
      t.references :tour_bus_pattern, null: false, foreign_key: true
      t.references :tour_start_location, null: false, foreign_key: true
      t.date :departure_date
      t.string :day_of_week
      t.integer :is_weekend, default: 0
      t.integer :bus_no
      t.integer :reserved_seats
      t.integer :available_seats
      t.jsonb :seats_map

      t.timestamps
    end
  end
end
