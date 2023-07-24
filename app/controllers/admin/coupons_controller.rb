# frozen_string_literal: true

class Admin::CouponsController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Admin::CouponOperations::Create.new(actor, params).call,
           serializer: Admin::Coupons::CreateSerializer, root: 'coupons'
  end

  def update
    render json: Admin::CouponOperations::Update.new(actor, params).call,
           serializer: Admin::Coupons::UpdateSerializer, root: 'coupons'
  end

  def show
    render json: Admin::CouponOperations::Show.new(actor, params).call,
           serializer: Admin::CouponTours::ShowSerializer, root: 'coupons'
  end

  def index
    coupons = Admin::CouponOperations::Index.new(actor, params).call
    render json: coupons, each_serializer: Admin::CouponTours::IndexSerializer,
           meta: pagination_dict(coupons), root: 'data', adapter: :json
  end

  def destroy
    render json: Admin::CouponOperations::Destroy.new(actor, params).call,
           serializer: Admin::Coupons::CreateSerializer, root: 'coupons'
  end
end
