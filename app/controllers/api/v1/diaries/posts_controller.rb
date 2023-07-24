# frozen_string_literal: true

class Api::V1::Diaries::PostsController < ApiV1Controller
  before_action :authentication!

  def index
    posts = Api::DiaryOperations::PostOperations::Index.new(actor, params).call
    render json: posts, each_serializer: Api::Diaries::Posts::IndexSerializer, actor: actor,
           meta: pagination_dict(posts), root: 'data', adapter: :json
  end

  def show
    post = Api::DiaryOperations::PostOperations::Show.new(actor, params).call
    render json: post, serializer: Api::Diaries::Posts::IndexSerializer, actor: actor
  end
end
