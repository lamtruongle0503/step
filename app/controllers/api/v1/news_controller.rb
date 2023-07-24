# frozen_string_literal: true

class Api::V1::NewsController < ApiV1Controller
  before_action :authentication!

  def index
    news = Api::NewOperations::Index.new(nil, params).call
    render json: news,
           each_serializer: Api::News::IndexSerializer,
           meta: pagination_dict(news), root: 'data', adapter: :json
  end
end
