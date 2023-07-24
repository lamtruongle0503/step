# frozen_string_literal: true

class Admin::EcommerceOperations::CampaignOperations::Show < ApplicationOperation
  def call
    authorize nil, Ecommerces::CampaignPolicy

    Campaign.includes(:assets).find(params[:id])
  end
end
