# frozen_string_literal: true

class Api::Tours::AttributeSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :code,
             :start_date,
             :end_date,
             :title,
             :coupons

  has_many :assets, serializer: Assets::AttributesSerializer

  def coupons
    coupons = object.coupons.find_coupon_by_type_coupon_of_coupon_tour
    coupons.map { |cp| Api::Coupons::AttributeSerializer.new(cp).as_json }
  end
end
