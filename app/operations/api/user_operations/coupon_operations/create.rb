# frozen_string_literal: true

class Api::UserOperations::CouponOperations::Create < ApplicationOperation
  attr_reader :coupon

  def initialize(actor, params)
    super
    @coupon = Coupon.find(params[:coupon_id])
  end

  def call
    actor.coupon_users.create!(coupon: coupon)
  end
end
