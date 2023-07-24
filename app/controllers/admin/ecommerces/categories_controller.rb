# frozen_string_literal: true

class Admin::Ecommerces::CategoriesController < ApiV1Controller
  before_action :authentication!

  def index
    categories = Admin::EcommerceOperations::CategoryOperations::Index.new(actor, params).call
    render json: categories, each_serializer: Admin::Ecommerces::Categories::IndexSerializer
  end

  def show
    render json: Admin::EcommerceOperations::CategoryOperations::Show.new(actor, params).call,
           serializer: Admin::Ecommerces::Categories::ShowSerializer, root: 'categories'
  end

  def create
    render json: Admin::EcommerceOperations::CategoryOperations::Create.new(actor, params).call,
           serializer: Admin::Ecommerces::Categories::CreateSerializer, root: 'categories'
  end

  def update
    render json: Admin::EcommerceOperations::CategoryOperations::Update.new(actor, params).call,
           serializer: Admin::Ecommerces::Categories::UpdateSerializer, root: 'categories'
  end

  def destroy
    render json: Admin::EcommerceOperations::CategoryOperations::Destroy.new(actor, params).call,
           serializer: Admin::Ecommerces::Categories::DestroySerializer, root: 'categories'
  end
end
