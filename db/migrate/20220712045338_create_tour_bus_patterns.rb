class CreateTourBusPatterns < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_bus_patterns do |t|
      t.string :name
      t.integer :capacity
      t.jsonb :map

      t.timestamps
    end
  end
end
