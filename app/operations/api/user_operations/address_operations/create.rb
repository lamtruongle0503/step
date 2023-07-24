# frozen_string_literal: true

class Api::UserOperations::AddressOperations::Create < ApplicationOperation
  def call
    UserContracts::AddressContracts::Create.new(address_params).valid!
    new_address_params = check_first_record? ? address_params.merge(is_default: true) : address_params
    actor.addresses.update_all(is_default: false) if params[:is_default]
    actor.addresses.create!(new_address_params)
  end

  private

  def check_first_record?
    actor.addresses.blank?
  end

  def address_params
    params.permit(:full_name, :postcode, :address1, :address2, :telephone, :is_default)
  end
end
