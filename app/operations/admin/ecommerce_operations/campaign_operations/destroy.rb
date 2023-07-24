# frozen_string_literal: true

class Admin::EcommerceOperations::CampaignOperations::Destroy < ApplicationOperation
  def call
    authorize nil, Ecommerces::CampaignPolicy

    Campaign.find(params[:id])&.destroy!
  end
end
