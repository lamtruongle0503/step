# frozen_string_literal: true

class Api::EcommerceOperations::CampaignOperations::Show < ApplicationOperation
  def call
    Campaign.includes(products: %i[assets_modules assets product_sizes]).find(params[:id])
  end
end
