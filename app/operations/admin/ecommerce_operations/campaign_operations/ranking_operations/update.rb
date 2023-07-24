# frozen_string_literal: true

class Admin::EcommerceOperations::CampaignOperations::RankingOperations::Update < ApplicationOperation
  def call
    EcommerceContracts::CampaignContracts::RankingContracts::Create.new(campaign_params).valid!
    ActiveRecord::Base.transaction do
      update_campaigns!
    end
  end

  private

  def campaign_params
    params.permit(campaign_attributes: %i[id ranking])
  end

  def update_campaigns!
    campaign_ids = params[:campaign_attributes].pluck(:id)
    id_campaigns = Campaign.find(campaign_ids).index_by(&:id)
    campaign_params[:campaign_attributes].each do |campaign_param|
      campaign = id_campaigns[campaign_param[:id].to_i]
      campaign.update!(campaign_param)
    end
  end
end
