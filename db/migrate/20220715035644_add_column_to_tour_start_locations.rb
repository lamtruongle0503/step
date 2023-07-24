class AddColumnToTourStartLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_start_locations, :prefecture_id, :integer, foreign_key: true
    add_column :tour_start_locations, :setting_date, :date
    add_column :tour_start_locations, :setting_time, :string
  end
end
