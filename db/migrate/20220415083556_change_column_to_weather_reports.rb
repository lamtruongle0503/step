class ChangeColumnToWeatherReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :weather_reports, :sunrise
    remove_column :weather_reports, :sunset
    add_column :weather_reports, :sunrise, :integer
    add_column :weather_reports, :sunset, :integer
  end
end
