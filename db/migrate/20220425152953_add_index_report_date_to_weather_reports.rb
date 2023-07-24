class AddIndexReportDateToWeatherReports < ActiveRecord::Migration[6.1]
  def change
    add_index :weather_reports, :report_date
  end
end
