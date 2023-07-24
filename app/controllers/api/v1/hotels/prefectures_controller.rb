# frozen_string_literal: true

class Api::V1::Hotels::PrefecturesController < ApiV1Controller
  def index
    prefectures = Api::HotelOperations::PrefectureOperations::Index.new(nil, params).call
    render json: prefectures,
           each_serializer: Api::Hotels::Prefectures::IndexSerializer, root: 'data', adapter: :json
  end
end
