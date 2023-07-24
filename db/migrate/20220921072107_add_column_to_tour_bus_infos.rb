class AddColumnToTourBusInfos < ActiveRecord::Migration[6.1]
  def change
    remove_reference :tour_bus_infos, :tour_start_location, null: false, foreign_key: true
    add_column :tour_bus_infos , :tour_start_location_id, :integer
    add_column :tour_bus_infos , :tour_stay_departure_id, :integer
  end
end
