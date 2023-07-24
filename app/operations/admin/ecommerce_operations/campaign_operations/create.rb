# frozen_string_literal: true

class Admin::EcommerceOperations::CampaignOperations::Create < ApplicationOperation
  def call
    authorize nil, Ecommerces::CampaignPolicy
    EcommerceContracts::CampaignContracts::Create.new(campaign_params).valid!
    create_campaign!
  end

  private

  def create_campaign!
    Campaign.create!(campaign_params)
  end

  def campaign_params
    params.permit(:name).merge(code:    generate_code(Campaign.name),
                               ranking: generate_ranking(Campaign.name))
  end
end
