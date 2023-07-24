# frozen_string_literal: true

class Api::V1::Users::CouponsController < ApiV1Controller
  before_action :authentication!, only: :create
  before_action :authentication_ec!, only: :index

  def create
    render json: Api::UserOperations::CouponOperations::Create.new(actor, params).call,
           serializer: Api::Users::Coupons::CreateSerializer, root: 'users'
  end

  def index
    render json: Api::UserOperations::CouponOperations::Index.new(@actor_ec, params).call,
           each_serializer: Api::Users::Coupons::IndexSerializer, root: 'users'
  end
end
