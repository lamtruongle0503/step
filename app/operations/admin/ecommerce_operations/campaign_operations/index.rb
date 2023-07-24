# frozen_string_literal: true

class Admin::EcommerceOperations::CampaignOperations::Index < ApplicationOperation
  def call
    authorize nil, Ecommerces::CampaignPolicy

    Campaign.includes(:assets).order(:ranking)
  end
end
