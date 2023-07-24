class ChangeColumnSunriseSunsetWeatherReports < ActiveRecord::Migration[6.1]
  def change
    change_column :weather_reports, :sunrise, :time
    change_column :weather_reports, :sunset, :time
  end
end
