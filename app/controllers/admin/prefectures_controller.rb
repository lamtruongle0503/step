# frozen_string_literal: true

class Admin::PrefecturesController < ApiV1Controller
  before_action :authentication!

  def index
    render json: Admin::PrefectureOperations::Index.new(actor, params).call,
           each_serializer: Prefectures::AttributesSerializer, root: 'prefectures'
  end
end
