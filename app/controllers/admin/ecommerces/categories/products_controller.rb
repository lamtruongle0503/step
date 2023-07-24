# frozen_string_literal: true

class Admin::Ecommerces::Categories::ProductsController < ApiV1Controller
  before_action :authentication!

  def index
    products = Admin::EcommerceOperations::CategoryOperations::ProductOperations::Index
               .new(actor, params).call
    render json: products, each_serializer: Admin::Ecommerces::Categories::Products::IndexSerializer,
           meta: pagination_dict(products), root: 'data', adapter: :json
  end
end
