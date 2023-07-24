# frozen_string_literal: true

class WeatherApiService
  attr_reader :module_type,
              :module_name,
              :prefecture_name,
              :weather_data,
              :weather_reports,
              :report_date,
              :type

  def initialize(type, module_type, module_name, prefecture_name, weather_data)
    @type = type
    @report_date = Date.current
    @module_type = module_type
    @module_name = module_name
    @prefecture_name = prefecture_name
    @weather_data = weather_data
    @weather_reports = []
  end

  def import_weather_reports!
    location = find_location
    build_hourly_weather_reports!(location, weather_data)
    build_daily_weather_reports!(location, weather_data)
    ActiveRecord::Base.transaction do
      delete_out_date_report!
      delete_old_report!(location, [WeatherReport::DAILY, WeatherReport::HOURLY])
      WeatherReport.import!(
        weather_reports.flatten.compact.uniq,
      )
    end
  end

  private

  def find_location
    if module_type == District.name
      District.joins(:prefecture).find_by!(prefecture: { name: prefecture_name },
                                           name:       module_name)
    elsif module_type == Prefecture.name
      Prefecture.find_by!(name: module_name)
    end
  end

  def delete_out_date_report!
    out_date_reports = WeatherReport.where(report_date: Date.current - 3.days)
    out_date_reports.each(&:really_destroy!)
  end

  def delete_old_report!(location, type)
    reports = WeatherReport.where(report_date: report_date, module: location, report_type: type)
    reports.update_all(deleted_at: Time.zone.now) if reports.any?
  end

  def build_hourly_weather_reports!(location, data)
    reports = []
    data[:forecast][:forecastday].each do |forecastday|
      sunrise  = Time.zone.parse((forecastday[:astro][:sunrise]).to_s)
      sunset   = Time.zone.parse((forecastday[:astro][:sunset]).to_s)
      moonrise = Time.zone.parse((forecastday[:astro][:moonrise]).to_s)
      moonset  = Time.zone.parse((forecastday[:astro][:moonset]).to_s)
      temp_min = forecastday[:day][:mintemp_c]
      temp_max = forecastday[:day][:maxtemp_c]
      reports << forecastday[:hour].map do |obj|
        time = Time.zone.parse(obj[:time])
        build_weather_reports(
          location,
          obj,
          sunrise,
          sunset,
          moonrise,
          moonset,
          WeatherReport::HOURLY,
          time,
          obj[:temp_c],
          temp_min,
          temp_max,
          obj[:humidity],
        )
      end
      weather_reports.push(reports)
    end
  end

  def build_daily_weather_reports!(location, data)
    reports    = data[:forecast][:forecastday].map do |forecastday|
      sunrise  = Time.zone.parse((forecastday[:astro][:sunrise]).to_s)
      sunset   = Time.zone.parse((forecastday[:astro][:sunset]).to_s)
      moonrise = Time.zone.parse((forecastday[:astro][:moonrise]).to_s)
      moonset  = Time.zone.parse((forecastday[:astro][:moonset]).to_s)
      temp_min = forecastday[:day][:mintemp_c]
      temp_max = forecastday[:day][:maxtemp_c]
      obj      = forecastday[:day]
      build_weather_reports(
        location,
        obj,
        sunrise,
        sunset,
        moonrise,
        moonset,
        WeatherReport::DAILY,
        Time.zone.parse(forecastday[:date]),
        obj[:avgtemp_c],
        temp_min,
        temp_max,
        obj[:avghumidity],
      )
    end
    weather_reports.push(reports)
  end

  def build_weather_reports(location, obj, sunrise, sunset, moonrise, moonset, report_type, time, temperature, temperature_min, temperature_max, humidity) # rubocop:disable Metrics/ParameterLists
    {
      module_type:     location.class.name,
      module_id:       location.id,
      report_date:     report_date,
      humidity:        humidity,
      temperature:     temperature,
      temperature_min: temperature_min,
      temperature_max: temperature_max,
      pressure:        obj[:pressure_mb],
      wind_speed:      obj[:wind_kph],
      wind_deg:        obj[:wind_degree],
      sunrise:         sunrise,
      sunset:          sunset,
      moonrise:        moonrise,
      moonset:         moonset,
      cloud:           obj[:cloud],
      condition:       obj[:condition][:text],
      condition_id:    obj[:condition][:code],
      description:     nil,
      icon_url:        obj[:condition][:icon],
      time:            time,
      wind_gust:       obj[:gust_kph],
      dew_point:       obj[:dewpoint_c],
      visibility:      obj[:vis_km],
      uvi:             obj[:uv],
      rain:            obj[:precip_mm],
      report_type:     report_type,
      icon:            nil,
    }
  end
end
