# frozen_string_literal: true

class Api::UserOperations::AddressOperations::StatusOperations::Update < ApplicationOperation
  attr_reader :address

  def initialize(actor, params)
    super
    @address = Address.find(params[:address_id])
  end

  def call
    update_address!
  end

  private

  def update_address!
    return if address.is_default

    actor.addresses.where(is_default: true).update_all(is_default: false)
    address.update!(is_default: true)
  end
end
