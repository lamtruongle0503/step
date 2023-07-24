# frozen_string_literal: true

class Admin::UserOperations::AddressOperations::Index < ApplicationOperation
  def call
    user = User.find(params[:id])
    user.addresses.order(is_default: :desc)
  end
end
