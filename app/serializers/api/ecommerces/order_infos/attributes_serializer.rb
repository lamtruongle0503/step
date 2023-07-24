# frozen_string_literal: true

class Api::Ecommerces::OrderInfos::AttributesSerializer < ApplicationSerializer
  attributes :id, :buyer_name, :postal_code, :delivery_date, :delivery_start_time,
             :delivery_end_time, :address1, :address2, :content

  def buyer_name
    return object.address&.full_name if object.buy_name.blank?

    object.buy_name
  end

  def postal_code
    object.address&.postcode
  end

  def address1
    object.address&.address1
  end

  def address2
    object.address&.address2
  end
end
