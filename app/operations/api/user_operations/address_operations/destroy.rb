# frozen_string_literal: true

class Api::UserOperations::AddressOperations::Destroy < ApplicationOperation
  attr_reader :address

  def initialize(actor, params)
    super
    @address = Address.find(params[:id])
  end

  def call
    is_default_address = address.is_default
    address.destroy!
    actor.addresses.first&.update!(is_default: true) if is_default_address
  end
end
