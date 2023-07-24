# frozen_string_literal: true

class Api::V1::Weathers::SyncController < ApiV1Controller
  def create
    Api::WeatherOperations::SyncOperations::Create.new(nil, params).call
    render json: {}
  end
end
