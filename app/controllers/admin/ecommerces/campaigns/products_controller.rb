# frozen_string_literal: true

class Admin::Ecommerces::Campaigns::ProductsController < ApiV1Controller
  before_action :authentication!

  def index
    products = Admin::EcommerceOperations::CampaignOperations::ProductOperations::Index
               .new(actor, params).call
    render json: products, each_serializer: Admin::Ecommerces::Campaigns::Products::IndexSerializer,
           meta: pagination_dict(products), root: 'data', adapter: :json
  end

  def create
    render json:       Admin::EcommerceOperations::CampaignOperations::ProductOperations::Create
      .new(actor, params).call,
           serializer: Admin::Ecommerces::Campaigns::Products::CreateSerializer
  end

  def destroy
    render json:       Admin::EcommerceOperations::CampaignOperations::ProductOperations::Destroy
      .new(actor, params).call,
           serializer: Admin::Ecommerces::Campaigns::Products::DestroySerializer
  end
end
