class AddColumnTimeToWeatherReports < ActiveRecord::Migration[6.1]
  def change
    add_column :weather_reports, :time, :integer
  end
end
