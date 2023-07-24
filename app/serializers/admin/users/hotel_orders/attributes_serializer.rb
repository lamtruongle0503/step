# frozen_string_literal: true

class Admin::Users::HotelOrders::AttributesSerializer < ApplicationSerializer
  attributes :id, :order_no, :created_at, :check_in, :check_out, :hotel_name,
             :person_total, :total

  def created_at
    object.created_at.to_date
  end

  def hotel_name
    object.hotel.name
  end
end
