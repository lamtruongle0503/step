# frozen_string_literal: true

class Admin::CouponTours::ShowSerializer < Admin::CouponTours::AttributesSerializer
  has_many :coupons, serializer: Admin::CouponTours::Coupons::AttributesSerializer
end
