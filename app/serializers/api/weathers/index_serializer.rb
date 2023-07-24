# frozen_string_literal: true

class Api::Weathers::IndexSerializer < ApplicationSerializer
  attributes :current, :hourly, :daily

  def current # rubocop:disable Metrics/PerceivedComplexity
    return if object.blank?

    data = object.select do |obj|
      obj['type'] == 'current'
    end
    return if data.blank?

    chance_of_rain = nil

    hourly = object.select { |obj| obj['type'] == 'forecast' }.last['data']
    hourly['daily'].each_with_object([]) do |obj, _arr|
      obj['hour'].each do |obj_hour|
        time = Time.zone.parse(obj_hour['time'])
        unless time.hour == Time.zone.now.hour &&
               Time.zone.parse(obj_hour['time']).to_date == Time.zone.now.to_date
          next
        end

        chance_of_rain = obj_hour['chance_of_rain']
      end
    end
    Api::Weathers::AttributesSerializer.new(
      data.first['data'].merge('chance_of_rain' => chance_of_rain),
    ).as_json
  end

  def hourly
    return if object.blank?

    hourly = object.select { |obj| obj['type'] == 'forecast' }.last['data']
    hourly['daily'].each_with_object([]) do |obj, arr|
      obj['hour'].each do |obj_hour|
        time = Time.zone.parse(obj_hour['time'])
        next unless time > Time.zone.now && time < Time.zone.now + 1.days

        arr << Api::Weathers::AttributesSerializer.new(obj_hour.reverse_merge!(obj.except('hour'))).as_json
      end
    end
  end

  def daily
    return if object.blank?

    hourly = object.select { |obj| obj['type'] == 'forecast' }.last['data']
    hourly['daily'].map do |obj_daily|
      obj_daily['hour'].each_with_object({}) do |obj_hour, hash|
        if Time.zone.parse(obj_hour['time']) == obj_daily['date'].to_date.midday
          hash[:day] =
            Api::Weathers::AttributesSerializer.new(obj_hour.reverse_merge!(obj_daily.except('hour'))).as_json
        elsif Time.zone.parse(obj_hour['time']) == obj_daily['date'].to_date + 21.hours
          hash[:night] =
            Api::Weathers::AttributesSerializer.new(obj_hour.reverse_merge!(obj_daily.except('hour'))).as_json
        end
      end
    end
  end
end
