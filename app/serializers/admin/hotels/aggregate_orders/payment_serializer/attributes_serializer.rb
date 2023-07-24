# frozen_string_literal: true

class Admin::Hotels::AggregateOrders::PaymentSerializer::AttributesSerializer < ApplicationSerializer
  attributes :id, :order_no, :created_at, :full_name, :furigana, :check_in, :check_out, :person_total,
             :total, :used_points, :price_room, :price_sale_off_stay_night, :price_children
  belongs_to :coupon, serializer: Admin::Hotels::Coupons::AttributesSerializer

  def full_name
    object.user.full_name
  end

  def furigana
    object.user.furigana
  end
end
