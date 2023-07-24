class ChangeColumnDateToWeatherReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :weather_reports, :report_date, :int
    remove_column :weather_reports, :time, :int
    remove_column :weather_reports, :sunrise, :int
    remove_column :weather_reports, :sunset, :int

    add_column :weather_reports, :report_date, :date
    add_column :weather_reports, :time, :datetime
    add_column :weather_reports, :sunrise, :datetime
    add_column :weather_reports, :sunset, :datetime
  end
end
