# frozen_string_literal: true

class Api::Tours::ShowSerializer < Api::Tours::AttributeSerializer
  attribute :coupons

  def coupons
    coupons_available = object.coupons_available.find_coupon_by_type_coupon_of_coupon_tour
    coupons_available.map { |cp| Api::Coupons::AttributeSerializer.new(cp).as_json }
  end
end
