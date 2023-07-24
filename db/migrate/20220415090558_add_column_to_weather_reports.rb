class AddColumnToWeatherReports < ActiveRecord::Migration[6.1]
  def change
    add_column :weather_reports, :wind_gust, :float
    add_column :weather_reports, :dew_point, :float
    add_column :weather_reports, :visibility, :integer
    add_column :weather_reports, :uvi, :integer
    add_column :weather_reports, :rain, :float
    add_column :weather_reports, :type, :integer
  end
end
