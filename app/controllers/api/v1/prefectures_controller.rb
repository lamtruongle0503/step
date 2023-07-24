# frozen_string_literal: true

class Api::V1::PrefecturesController < ApiV1Controller
  # before_action :authentication!

  def index
    render json: Api::PrefectureOperations::Index.new(nil, params).call,
           each_serializer: Prefectures::AttributesSerializer, root: 'prefectures'
  end
end
