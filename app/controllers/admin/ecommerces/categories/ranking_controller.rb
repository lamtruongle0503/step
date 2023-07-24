# frozen_string_literal: true

class Admin::Ecommerces::Categories::RankingController < ApiV1Controller
  before_action :authentication!

  def update
    Admin::EcommerceOperations::CategoryOperations::RankingOperations::Update.new(actor, params).call
    render json: {}
  end
end
