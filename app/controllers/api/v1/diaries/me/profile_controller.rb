# frozen_string_literal: true

class Api::V1::Diaries::Me::ProfileController < ApiV1Controller
  before_action :authentication!

  def index
    profile = Api::DiaryOperations::MeOperations::ProfileOperations::Index.new(actor, params).call
    render json: profile, serializer: Api::Diaries::Me::Profile::IndexSerializer, root: 'diaries'
  end

  def update
    Api::DiaryOperations::MeOperations::ProfileOperations::Update.new(actor, params).call
    render json: {}
  end
end
