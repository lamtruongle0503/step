# frozen_string_literal: true

class Api::V1::News::TopHeadlinesController < ApiV1Controller
  before_action :authentication!

  def index
    render json: Api::NewOperations::TopHeadlineOperations::Index.new(actor, params).call,
           each_serializer: Api::News::IndexSerializer, root: 'news'
  end
end
