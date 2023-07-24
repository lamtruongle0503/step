# frozen_string_literal: true

class Api::HotelOperations::PlanOperations::CouponOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_plan = @hotel.hotel_plans.find(params[:plan_id])
  end

  def call
    return [] unless @hotel_plan.is_use_coupon?

    @hotel.coupons.coupon_no_expiration
  end
end
