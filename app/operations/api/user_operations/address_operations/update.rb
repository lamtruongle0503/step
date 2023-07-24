# frozen_string_literal: true

class Api::UserOperations::AddressOperations::Update < ApplicationOperation
  attr_reader :address

  def initialize(actor, params)
    super
    @address = Address.find(params[:id])
  end

  def call
    UserContracts::AddressContracts::Update.new(address_params).valid!
    actor.addresses.update_all(is_default: false) if params[:is_default]
    address.update!(address_params)
    address
  end

  private

  def address_params
    params.permit(:full_name, :postcode, :address1, :address2, :telephone, :is_default)
  end
end
