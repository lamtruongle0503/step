class CreateTourStartLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_start_locations do |t|
      t.references :tour, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
