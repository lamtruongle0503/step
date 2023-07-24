# frozen_string_literal: true

class Api::Ecommerces::DeliveryTimeSettings::AttributesSerializer < ApplicationSerializer
  attributes :id
  attribute :start_time
  attribute :end_time

  def start_time
    object.start_time&.to_s(:time)
  end

  def end_time
    object.end_time&.to_s(:time)
  end
end
