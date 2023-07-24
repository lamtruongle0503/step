# frozen_string_literal: true

class Admin::Users::AddressesController < ApiV1Controller
  before_action :authentication!

  def index
    addresses = Admin::UserOperations::AddressOperations::Index.new(actor, params).call
    render json:            addresses,
           each_serializer: Admin::Users::Addresses::IndexSerializer
  end
end
