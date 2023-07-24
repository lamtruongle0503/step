class ChangeColumnSettingTimeTourStartLocations < ActiveRecord::Migration[6.1]
  def change
    remove_column :tour_start_locations, :setting_time
    add_column :tour_start_locations, :depature_time, :string
    add_column :tour_start_locations, :concentrate_time, :string
  end
end
