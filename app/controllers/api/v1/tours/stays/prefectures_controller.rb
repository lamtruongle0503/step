# frozen_string_literal: true

class Api::V1::Tours::Stays::PrefecturesController < ApiV1Controller
  def index
    prefectures = Api::TourOperations::StayOperations::PrefectureOperations::Index.new(actor, params).call
    render json: prefectures, serializer: Api::Tours::Stays::Prefectures::IndexSerializer, root: 'tours'
  end
end
