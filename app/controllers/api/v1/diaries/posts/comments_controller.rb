# frozen_string_literal: true

class Api::V1::Diaries::Posts::CommentsController < ApiV1Controller
  before_action :authentication!

  def create
    comment = Api::DiaryOperations::PostOperations::CommentOperations::Create.new(actor, params).call
    render json: comment, serializer: Api::Diaries::Posts::Comments::CreateSerializer, actor: actor
  end

  def destroy
    Api::DiaryOperations::PostOperations::CommentOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def index
    comments = Api::DiaryOperations::PostOperations::CommentOperations::Index.new(actor, params).call
    render json: comments, each_serializer: Api::Diaries::Posts::Comments::Meta::MetaSerializer, actor: actor,
           meta: pagination_dict(comments), root: 'data', adapter: :json
  end
end
