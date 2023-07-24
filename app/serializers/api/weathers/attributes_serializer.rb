# frozen_string_literal: true

class Api::Weathers::AttributesSerializer < ApplicationSerializer
  attributes :icon_url, :moonrise, :moonset, :sunrise, :sunset,
             :visibility, :temperature, :temperature_max, :temperature_min,
             :uvi, :pressure, :condition_id, :cloud, :wind_deg, :condition,
             :humidity, :wind_speed, :time, :chance_of_rain

  def moonrise
    return unless object['moonrise']

    Time.zone.parse(object['moonrise'])&.strftime('%H:%M:%S')
  end

  def moonset
    return unless object['moonset']

    Time.zone.parse(object['moonset'])&.strftime('%H:%M:%S')
  end

  def sunrise
    return unless object['sunrise']

    Time.zone.parse(object['sunrise'])&.strftime('%H:%M:%S')
  end

  def sunset
    return unless object['sunset']

    Time.zone.parse(object['sunset'])&.strftime('%H:%M:%S')
  end

  def icon_url
    object['icon_url']
  end

  def visibility
    object['visibility']
  end

  def temperature_max
    object['temperature_max']
  end

  def uvi
    object['uvi']
  end

  def pressure
    object['pressure']
  end

  def condition_id
    object['condition_id']
  end

  def cloud
    object['cloud']
  end

  def wind_deg
    object['wind_deg']
  end

  def condition
    object['condition']
  end

  def temperature_min
    object['temperature_min']
  end

  def temperature
    object['temperature']
  end

  def humidity
    object['humidity']
  end

  def wind_speed
    object['wind_speed']
  end

  def time
    object['time']
  end

  def chance_of_rain
    object['chance_of_rain']&.round(-1)
  end
end
