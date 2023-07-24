# frozen_string_literal: true

class Admin::Ecommerces::ProductsController < ApiV1Controller
  before_action :authentication!

  def index
    products = Admin::EcommerceOperations::ProductOperations::Index.new(actor, params).call
    render json: products, each_serializer: Admin::Ecommerces::Products::IndexSerializer,
           meta: pagination_dict(products), root: 'data', adapter: :json
  end

  def create
    render json: Admin::EcommerceOperations::ProductOperations::Create.new(actor, params).call,
           serializer: Admin::Ecommerces::Products::CreateSerializer, root: 'ecommerces/products'
  end

  def update
    render json: Admin::EcommerceOperations::ProductOperations::Update.new(actor, params).call,
           serializer: Admin::Ecommerces::Products::CreateSerializer, root: 'ecommerces/products'
  end

  def show
    render json: Admin::EcommerceOperations::ProductOperations::Show.new(actor, params).call,
           serializer: Admin::Ecommerces::Products::ShowSerializer, root: 'ecommerces/products'
  end

  def destroy
    render json: Admin::EcommerceOperations::ProductOperations::Destroy.new(actor, params).call,
           serializer: Admin::Ecommerces::Products::DestroySerializer, root: 'ecommerces/products'
  end
end
