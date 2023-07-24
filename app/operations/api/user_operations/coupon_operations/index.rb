# frozen_string_literal: true

class Api::UserOperations::CouponOperations::Index < ApplicationOperation
  def call
    return [] unless actor.present?

    actor.coupon_users.includes(:coupon).available.map(&:coupon)
  end
end
