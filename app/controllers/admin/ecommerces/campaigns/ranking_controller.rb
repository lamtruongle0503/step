# frozen_string_literal: true

class Admin::Ecommerces::Campaigns::RankingController < ApiV1Controller
  before_action :authentication!

  def update
    Admin::EcommerceOperations::CampaignOperations::RankingOperations::Update.new(actor, params).call
    render json: {}
  end
end
