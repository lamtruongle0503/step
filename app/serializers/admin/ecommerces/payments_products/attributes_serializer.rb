# frozen_string_literal: true

class Admin::Ecommerces::PaymentsProducts::AttributesSerializer < ApplicationSerializer
  attributes :id, :payment

  def payment
    Admin::Payments::IndexSerializer.new(object.payment)
  end
end
