# frozen_string_literal: true

class Api::V1::TourCouponsController < ApiV1Controller
  before_action :authentication!

  def index
    render json:            Api::TourCouponOperations::Index.new(nil, params).call,
           each_serializer: Api::TourCoupons::IndexSerializer
  end

  def show
    render json:       Api::TourCouponOperations::Show.new(nil, params).call,
           serializer: Api::TourCoupons::ShowSerializer
  end
end
