# frozen_string_literal: true

class Api::WeatherOperations::SyncOperations::Create < ApplicationOperation
  attr_reader :module_type,
              :module_name,
              :prefecture_name,
              :data,
              :type

  def initialize(actor, params)
    super
    @type            = params[:type]
    @module_type     = params[:module_type]
    @module_name     = params[:module_name]
    @prefecture_name = params[:prefecture_name]
    @data            = params[:data]
  end

  def call
    service = WeatherApiService.new(
      type, module_type, module_name, prefecture_name, data
    )
    service.import_weather_reports!
  end
end
