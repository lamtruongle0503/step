class AddColumnIconToWeatherReport < ActiveRecord::Migration[6.1]
  def change
    add_column :weather_reports, :icon, :string
  end
end
