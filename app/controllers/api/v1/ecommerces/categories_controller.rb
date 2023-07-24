# frozen_string_literal: true

class Api::V1::Ecommerces::CategoriesController < ApiV1Controller
  def index
    render json: Api::EcommerceOperations::CategoryOperations::Index.new(nil, params).call,
           each_serializer: Api::Ecommerces::Categories::IndexSerializer, root: 'ecommerces'
  end

  def show
    render json: Api::EcommerceOperations::CategoryOperations::Show.new(nil, params).call,
           serializer: Api::Ecommerces::Categories::ShowSerializer, root: 'ecommerces'
  end
end
