# frozen_string_literal: true

class EcommerceContracts::CouponContracts::Base < ApplicationContract
  attribute :user_id, Integer
  attribute :coupon_id, Integer
end
