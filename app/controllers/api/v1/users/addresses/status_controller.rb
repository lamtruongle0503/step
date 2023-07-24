# frozen_string_literal: true

class Api::V1::Users::Addresses::StatusController < ApiV1Controller
  before_action :authentication!

  def update
    Api::UserOperations::AddressOperations::StatusOperations::Update.new(actor, params).call
    render json: {}
  end
end
