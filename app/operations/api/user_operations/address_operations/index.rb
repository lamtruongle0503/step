# frozen_string_literal: true

class Api::UserOperations::AddressOperations::Index < ApplicationOperation
  def call
    actor.addresses.order(is_default: :desc)
  end
end
