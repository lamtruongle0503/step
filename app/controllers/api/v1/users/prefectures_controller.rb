# frozen_string_literal: true

class Api::V1::Users::PrefecturesController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Api::UserOperations::PrefectureOperations::Create.new(actor, params).call,
           serializer: Api::Users::Prefectures::CreateSerializer, root: 'users'
  end

  def index
    render json: Api::UserOperations::PrefectureOperations::Index.new(actor, params).call,
           serializer: Api::Users::Prefectures::IndexSerializer, root: 'users'
  end
end
