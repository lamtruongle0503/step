class AddColumnToTourStartLocationTourStayDeparture < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_start_locations, :code, :string
    add_column :tour_stay_departures, :code, :string
  end
end
