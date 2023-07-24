# frozen_string_literal: true

class Api::V1::Diaries::Me::PostsController < ApiV1Controller
  before_action :authentication!, only: %i[create update show index]

  def create
    Api::DiaryOperations::MeOperations::PostOperations::Create.new(actor, params).call
    render json: {}
  end

  def update
    post = Api::DiaryOperations::MeOperations::PostOperations::Update.new(actor, params).call
    render json: post, serializer: Api::Diaries::Me::Posts::ShowSerializer, actor: actor
  end

  def index
    posts = Api::DiaryOperations::MeOperations::PostOperations::Index.new(actor, params).call
    render json: posts, each_serializer: Api::Diaries::Me::Posts::IndexSerializer, actor: actor,
           meta: pagination_dict(posts), root: 'data', adapter: :json
  end

  def show
    post = Api::DiaryOperations::MeOperations::PostOperations::Show.new(actor, params).call
    render json: post, serializer: Api::Diaries::Me::Posts::ShowSerializer, actor: actor
  end

  def destroy
    Api::DiaryOperations::MeOperations::PostOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
