# frozen_string_literal: true

class Api::V1::Hotels::RankingsController < ApiV1Controller
  def index
    hotels = Api::HotelOperations::RankingOperations::Index.new(nil, params).call
    render json: hotels, each_serializer: Api::Hotels::Rankings::IndexSerializer, root: 'data', adapter: :json
  end
end
