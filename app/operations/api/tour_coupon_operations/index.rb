# frozen_string_literal: true

class Api::TourCouponOperations::Index < ApplicationOperation
  def call
    prefecture = Prefecture.find(params[:prefecture_id]) if params[:prefecture_id].present?
    return TourCoupon.all.not_expired(Date.today) unless prefecture.present?

    prefecture.tour_coupons.not_expired(Date.today)
  end
end
