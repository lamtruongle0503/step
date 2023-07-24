class AddColumnToTourStartLocationAndTourStayDeparture < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_start_locations, :is_setting, :boolean, :default => false
    add_column :tour_stay_departures, :is_setting, :boolean, :default => false
  end
end
