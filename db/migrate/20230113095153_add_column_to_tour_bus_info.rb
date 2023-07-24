class AddColumnToTourBusInfo < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_bus_infos, :concentrate_time, :string
    add_column :tour_bus_infos, :departure_time, :string
  end
end
