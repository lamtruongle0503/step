# frozen_string_literal: true

class Admin::DeliveryOperations::Index < ApplicationOperation
  def call
    Delivery.all
  end
end
