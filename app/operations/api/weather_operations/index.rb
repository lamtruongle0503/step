# frozen_string_literal: true

class Api::WeatherOperations::Index < ApplicationOperation
  attr_reader :module_type, :module_id

  def initialize(actor, params)
    super
    @module_type = params[:module_type]
    @module_id   = params[:module_id]
  end

  def call
    location = module_type.constantize.find(module_id)
    prefecture_name = location.is_a?(Prefecture) ? location.name : location.prefecture.name
    weather_data(location.name, module_type, prefecture_name)
  end

  def weather_data(module_name, module_type, prefecture_name)
    client = WeatherService.new
    client.query_by_module(module_type, module_name, prefecture_name).items
  end
end
