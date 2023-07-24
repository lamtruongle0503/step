class CreateWeatherReports < ActiveRecord::Migration[6.1]
  def change
    create_table :weather_reports do |t|
      t.references :module, polymorphic: true, index: true
      t.integer :report_date, index: true
      t.float :humidity
      t.float :temperature
      t.float :temperature_min
      t.float :temperature_max
      t.float :pressure
      t.float :wind_speed
      t.float :wind_deg
      t.date :sunrise
      t.date :sunset
      t.integer :cloud
      t.string :condition
      t.integer :condition_id
      t.string :description
      t.string :icon_url
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
