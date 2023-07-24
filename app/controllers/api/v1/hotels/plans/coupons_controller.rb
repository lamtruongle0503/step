# frozen_string_literal: true

class Api::V1::Hotels::Plans::CouponsController < ApiV1Controller
  before_action :authentication!

  def index
    coupons = Api::HotelOperations::PlanOperations::CouponOperations::Index.new(actor, params).call
    render json: coupons, each_serializer: Api::Hotels::Coupons::AttributesSerializer
  end
end
