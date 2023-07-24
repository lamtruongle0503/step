# frozen_string_literal: true

class Api::V1::Tours::Indays::PrefecturesController < ApiV1Controller
  def index
    prefectures = Api::TourOperations::IndayOperations::PrefectureOperations::Index.new(nil, params).call
    render json: prefectures, serializer: Api::Tours::Indays::Prefectures::IndexSerializer, root: 'tours'
  end
end
