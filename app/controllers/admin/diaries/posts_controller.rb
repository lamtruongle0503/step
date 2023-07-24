# frozen_string_literal: true

class Admin::Diaries::PostsController < ApiV1Controller
  before_action :authentication!

  def index
    posts = Admin::DiaryOperations::PostOperations::Index.new(actor, params).call
    render json: posts, each_serializer: Admin::Diaries::Posts::IndexSerializer,
           meta: pagination_dict(posts), root: 'data', adapter: :json
  end

  def show
    post = Admin::DiaryOperations::PostOperations::Show.new(actor, params).call
    render json: post, serializer: Admin::Diaries::Posts::ShowSerializer
  end

  def destroy
    Admin::DiaryOperations::PostOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def update
    Admin::DiaryOperations::PostOperations::Update.new(actor, params).call
    render json: {}
  end
end
