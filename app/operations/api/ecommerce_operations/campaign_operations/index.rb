# frozen_string_literal: true

class Api::EcommerceOperations::CampaignOperations::Index < ApplicationOperation
  def call
    @q = Campaign.ransack(params[:q])
    @users = @q.result(distinct: true).includes(:assets).order(:ranking).page(params[:page])
  end
end
