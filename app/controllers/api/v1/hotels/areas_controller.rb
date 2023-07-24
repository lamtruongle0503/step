# frozen_string_literal: true

class Api::V1::Hotels::AreasController < ApiV1Controller
  def index
    area_settings = Api::HotelOperations::AreaOperations::Index.new(nil, params).call
    render json: area_settings,
           each_serializer: Api::Hotels::Areas::IndexSerializer, root: 'data', adapter: :json
  end
end
