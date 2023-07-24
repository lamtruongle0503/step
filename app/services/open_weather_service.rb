# frozen_string_literal: true

class OpenWeatherService
  def initialize
    @client = OpenWeather::Client.new(
      api_key: ENV['WEATHER_API_KEY'] || Rails.application.credentials.weather_api_key,
    )
  end

  def current_weather(lat, lng)
    @client.one_call(lat: lat, lon: lng, lang: 'ja', exclude: ['minutely'], units: 'metric')
  end
end
