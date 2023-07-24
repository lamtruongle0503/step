# frozen_string_literal: true

class Admin::CouponOperations::Show < ApplicationOperation
  def call
    authorize Coupon
    CouponTour.includes(:prefectures, coupons: :assets).find(params[:id])
  end
end
