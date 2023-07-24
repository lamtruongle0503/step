# frozen_string_literal: true

class Admin::EcommerceOperations::CampaignOperations::ProductOperations::Index < ApplicationOperation
  def call
    Campaign.find(params[:campaign_id]).products.includes(:category).page(params[:page])
  end
end
