# frozen_string_literal: true

class Api::Ecommerces::Orders::Agencies::MetaSerializer < ApplicationSerializer
  attributes :id, :name, :deliveries, :payments, :is_free, :fee_shipping

  def deliveries
    object.deliveries.map do |delivery|
      Api::Ecommerces::Deliveries::AttributesSerializer.new(delivery).as_json
    end
  end

  def payments
    object.payments.map { |payment| Api::Ecommerces::Payments::AttributesSerializer.new(payment).as_json }
  end
end
