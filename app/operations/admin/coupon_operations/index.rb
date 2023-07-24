# frozen_string_literal: true

class Admin::CouponOperations::Index < ApplicationOperation
  def call
    authorize Coupon
    @q = CouponTour.includes(:tour, :prefectures).ransack(params[:q])

    @coupons = @q.result(distinct: true).newest.page(params[:page])
  end
end
