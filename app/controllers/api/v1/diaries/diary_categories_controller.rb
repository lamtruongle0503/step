# frozen_string_literal: true

class Api::V1::Diaries::DiaryCategoriesController < ApiV1Controller
  def index
    categories = Api::DiaryOperations::DiaryCategoryOperations::Index.new(actor, params).call
    render json: categories, each_serializer: Api::Diaries::Categories::Index
  end
end
