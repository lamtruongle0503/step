# frozen_string_literal: true

class Api::V1::Diaries::Posts::SearchController < ApiV1Controller
  before_action :authentication!

  def index
    posts = Api::DiaryOperations::PostOperations::SearchOperations::Index.new(actor, params).call
    render json: posts, each_serializer: Api::Diaries::Posts::IndexSerializer, actor: actor,
           meta: pagination_dict(posts), root: 'data', adapter: :json
  end
end
