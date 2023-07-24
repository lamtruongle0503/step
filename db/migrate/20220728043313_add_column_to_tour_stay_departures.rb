class AddColumnToTourStayDepartures < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_stay_departures, :concentrate_time, :string
    add_column :tour_stay_departures, :depature_time, :string
  end
end
