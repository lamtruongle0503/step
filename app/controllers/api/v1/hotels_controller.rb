# frozen_string_literal: true

class Api::V1::HotelsController < ApiV1Controller
  def index
    hotels = Api::HotelOperations::Index.new(nil, params).call
    render json: hotels, each_serializer: Api::Hotels::IndexSerializer, params: params[:q],
           meta: pagination_dict(hotels), root: 'data', adapter: :json
  end

  def show
    hotel = Api::HotelOperations::Show.new(nil, params).call
    render json: hotel, serializer: Api::Hotels::ShowSerializer
  end
end
