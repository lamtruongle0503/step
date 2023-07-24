# frozen_string_literal: true

class Admin::Hotels::Orders::AttributesSerializer < ApplicationSerializer
  attributes :id, :order_no, :status, :created_at, :check_in, :check_out, :hotel_name,
             :person_total, :total_order, :total, :used_points, :payment_method,
             :payment_status, :status, :date_cancel
  belongs_to :user, serializer: Admin::Hotels::Users::AttributesSerializer
  belongs_to :coupon, serializer: Admin::Hotels::Coupons::AttributesSerializer

  def total_order
    price_coupon = object.coupon ? object.coupon.price : 0
    point = object.used_points || 0
    (object.total + point + price_coupon).round
  end

  def hotel_name
    object.hotel.name
  end
end
