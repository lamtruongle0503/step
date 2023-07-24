# frozen_string_literal: true

class Api::V1::Diaries::Posts::LikesController < ApiV1Controller
  before_action :authentication!

  def create
    Api::DiaryOperations::PostOperations::LikeOperations::Create.new(actor, params).call
    render json: {}
  end

  def destroy
    Api::DiaryOperations::PostOperations::LikeOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def index
    users = Api::DiaryOperations::PostOperations::LikeOperations::Index.new(actor, params).call
    render json: users, each_serializer: Api::Diaries::Posts::Likes::IndexSerializer, actor: actor
  end
end
