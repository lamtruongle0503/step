class CreateTourHostelDepartures < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_hostel_departures do |t|
      t.references :tour, foreign_key: true
      t.references :tour_hostel, foreign_key: true
      t.string :option_ids, array: true, default: []
      t.string :note

      t.timestamps
    end
  end
end
