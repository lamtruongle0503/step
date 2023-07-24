# frozen_string_literal: true

class Admin::Ecommerces::CampaignsController < ApiV1Controller
  before_action :authentication!

  def index
    campaigns = Admin::EcommerceOperations::CampaignOperations::Index.new(actor, params).call
    render json: campaigns, each_serializer: Admin::Ecommerces::Campaigns::IndexSerializer
  end

  def create
    render json:       Admin::EcommerceOperations::CampaignOperations::Create.new(actor, params).call,
           serializer: Admin::Ecommerces::Campaigns::CreateSerializer
  end

  def update
    render json:       Admin::EcommerceOperations::CampaignOperations::Update.new(actor, params).call,
           serializer: Admin::Ecommerces::Campaigns::UpdateSerializer
  end

  def destroy
    render json:       Admin::EcommerceOperations::CampaignOperations::Destroy.new(actor, params).call,
           serializer: Admin::Ecommerces::Campaigns::DestroySerializer
  end

  def show
    render json:       Admin::EcommerceOperations::CampaignOperations::Show.new(actor, params).call,
           serializer: Admin::Ecommerces::Campaigns::ShowSerializer
  end
end
