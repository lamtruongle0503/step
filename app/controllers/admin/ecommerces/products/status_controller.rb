# frozen_string_literal: true

class Admin::Ecommerces::Products::StatusController < ApiV1Controller
  before_action :authentication!

  def update
    Admin::EcommerceOperations::ProductOperations::StatusOperations::Update.new(actor, params).call
    render json: {}
  end
end
