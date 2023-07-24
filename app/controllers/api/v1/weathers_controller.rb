# frozen_string_literal: true

class Api::V1::WeathersController < ApiV1Controller
  def index
    render json: Api::WeatherOperations::Index.new(nil, params).call,
           serializer: Api::Weathers::IndexSerializer, root: 'weathers'
  end
end
