# frozen_string_literal: true

class Admin::CouponOperations::Destroy < ApplicationOperation
  def call
    authorize Coupon

    coupon_tour = CouponTour.find(params[:id])
    ActiveRecord::Base.transaction do
      coupon_tour.destroy!
      coupon_tour.tour_coupon&.destroy!
    end
  end
end
