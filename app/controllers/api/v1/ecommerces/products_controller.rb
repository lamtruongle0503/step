# frozen_string_literal: true

class Api::V1::Ecommerces::ProductsController < ApiV1Controller
  before_action :authentication_ec!, except: :index

  def show
    product = Api::EcommerceOperations::ProductOperations::Show.new(@actor_ec, params).call
    render json: product,
           serializer: Api::Ecommerces::Products::ShowSerializer, actor: @actor_ec,
           root: 'ecommerces'
  end

  def index
    products = Api::EcommerceOperations::ProductOperations::Index.new(nil, params).call
    render json: products,
           each_serializer: Api::Ecommerces::Products::IndexSerializer,
           meta: pagination_dict(products), root: 'data', adapter: :json
  end
end
