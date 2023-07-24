# == Schema Information
#
# Table name: weather_reports
#
#  id              :bigint           not null, primary key
#  cloud           :integer
#  condition       :string
#  deleted_at      :datetime
#  description     :string
#  dew_point       :float
#  humidity        :float
#  icon            :string
#  icon_url        :string
#  module_type     :string
#  moonrise        :time
#  moonset         :time
#  pressure        :float
#  rain            :float
#  report_date     :date
#  report_type     :integer
#  sunrise         :time
#  sunset          :time
#  temperature     :float
#  temperature_max :float
#  temperature_min :float
#  time            :datetime
#  uvi             :integer
#  visibility      :integer
#  wind_deg        :float
#  wind_gust       :float
#  wind_speed      :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  condition_id    :integer
#  module_id       :bigint
#
# Indexes
#
#  index_weather_reports_on_module       (module_type,module_id)
#  index_weather_reports_on_report_date  (report_date)
#
class WeatherReport < ApplicationRecord
  acts_as_paranoid

  belongs_to :module, polymorphic: true
  belongs_to :prefecture, foreign_key: :module_id, optional: true
  belongs_to :district, foreign_key: :module_id, optional: true

  CURRENT  = 'current'.freeze
  DAILY    = 'daily'.freeze
  HOURLY   = 'hourly'.freeze
  FORECAST = 'forecast'.freeze

  enum report_type: { current: 1, hourly: 2, daily: 3 }
end
