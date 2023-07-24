# frozen_string_literal: true

class Admin::EcommerceOperations::CampaignOperations::Update < ApplicationOperation
  attr_reader :campaign

  def initialize(actor, params)
    super
    @campaign = Campaign.find(params[:id])
  end

  def call
    authorize nil, Ecommerces::CampaignPolicy
    ActiveRecord::Base.transaction do
      update_campaign!
      upload(campaign) if params[:file]
    end
    campaign.reload
  end

  private

  def update_campaign!
    EcommerceContracts::CampaignContracts::Update.new(campaign_params).valid!
    campaign.update!(campaign_params)
  end

  def campaign_params
    params.permit(:name, :description)
  end

  def upload(campaign)
    return unless params[:file]

    if params[:file].is_a? Array
      params[:file].each do |file|
        upload_multiple_file(campaign, file[:url], file[:type], file[:file_type])
      end
    else
      upload_multiple_file(campaign, params[:file][:url], params[:file][:type], params[:file][:file_type])
    end
  end
end
