class ChangeColumnTypeToWeatherReports < ActiveRecord::Migration[6.1]
  def change
    remove_column :weather_reports, :type
    add_column :weather_reports, :report_type, :integer
  end
end
