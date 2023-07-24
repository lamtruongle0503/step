class AddColumnToTourStayDeparture < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_stay_departures, :prefecture_id, :integer, foreign_key: true
  end
end
