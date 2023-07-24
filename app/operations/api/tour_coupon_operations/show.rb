# frozen_string_literal: true

class Api::TourCouponOperations::Show < ApplicationOperation
  def call
    TourCoupon.find(params[:id])
  end
end
