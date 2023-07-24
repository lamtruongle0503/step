# frozen_string_literal: true

class Admin::CouponTours::AttributesSerializer < ApplicationSerializer
  attributes :id, :start_time, :end_time, :publish_date, :updated_at, :prefectures, :tour

  def prefectures
    object.prefectures.map { |prefecture| Prefectures::AttributesSerializer.new(prefecture).as_json }
  end

  def tour
    Admin::TourCoupons::AttributesSerializer.new(object.tour_coupon).as_json if object.tour_coupon
  end
end
