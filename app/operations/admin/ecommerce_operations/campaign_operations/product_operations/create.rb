# frozen_string_literal: true

class Admin::EcommerceOperations::CampaignOperations::ProductOperations::Create < ApplicationOperation
  attr_reader :campaign, :product

  def initialize(actor, params)
    super

    @campaign = Campaign.find(params[:campaign_id])
    @product = Product.find(params[:product_id])
  end

  def call
    EcommerceContracts::CampaignContracts::ProductContracts::Create.new(product_params).valid!
    create_product!
    campaign
  end

  private

  def create_product!
    campaign.campaign_products.create!(product: product)
  end

  def product_params
    params.permit(:product_id, :campaign_id)
  end
end
