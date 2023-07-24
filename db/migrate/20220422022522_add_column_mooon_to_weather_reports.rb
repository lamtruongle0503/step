class AddColumnMooonToWeatherReports < ActiveRecord::Migration[6.1]
  def change
    add_column :weather_reports, :moonrise, :time
    add_column :weather_reports, :moonset, :time
  end
end
