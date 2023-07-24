class AddColumnToModelTourStayDepartures < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_stay_departures, :name, :string
  end
end
