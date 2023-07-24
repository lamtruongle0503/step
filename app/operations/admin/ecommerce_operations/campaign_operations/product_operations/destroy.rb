# frozen_string_literal: true

class Admin::EcommerceOperations::CampaignOperations::ProductOperations::Destroy < ApplicationOperation
  attr_reader :campaign_product

  def initialize(actor, params)
    super
    @campaign_product = CampaignProduct.find_by!(product_id:  params[:id],
                                                 campaign_id: params[:campaign_id])
  end

  def call
    campaign_product.destroy!
  end
end
