# frozen_string_literal: true

class Admin::Ecommerces::OrderInfos::AttributesSerializer < ApplicationSerializer
  attributes :id, :postal_code, :delivery_date, :delivery_end_time,
             :delivery_start_time, :address1, :address2, :content, :telephone, :full_name

  def delivery_start_time
    return unless object.delivery_start_time

    object.delivery_start_time.to_time.strftime('%H:%M')
  end

  def delivery_end_time
    return unless object.delivery_end_time

    object.delivery_end_time.to_time.strftime('%H:%M')
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

  def telephone
    object.address&.telephone
  end

  def full_name
    object.address&.full_name
  end
end
