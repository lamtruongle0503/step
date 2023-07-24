# frozen_string_literal: true

class Api::EcommerceOperations::CouponOperations::UserOperations::Index < ApplicationOperation
  def call
    actor.ecommerce_coupons.includes(:coupons_modules,
                                     :products)
         .ec_available.where(ecommerce_coupon_users: { is_used: false }).page(params[:page])
  end
end
