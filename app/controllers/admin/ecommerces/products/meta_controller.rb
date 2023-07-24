# frozen_string_literal: true

class Admin::Ecommerces::Products::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    products = Admin::EcommerceOperations::ProductOperations::MetaOperations::Index
               .new(actor, params).call
    render json: products, each_serializer: Admin::Ecommerces::Products::Meta::IndexSerializer
  end

  def show
    product = Admin::EcommerceOperations::ProductOperations::MetaOperations::Show.new(actor, params).call
    render json: product, serializer: Admin::Ecommerces::Products::Meta::ShowSerializer
  end
end
