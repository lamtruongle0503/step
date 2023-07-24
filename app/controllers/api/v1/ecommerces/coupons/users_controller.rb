# frozen_string_literal: true

class Api::V1::Ecommerces::Coupons::UsersController < ApiV1Controller
  def create
    Api::EcommerceOperations::CouponOperations::UserOperations::Create.new(actor, params).call
    render json: {}
  end

  def index
    coupons = Api::EcommerceOperations::CouponOperations::UserOperations::Index.new(actor, params).call
    render json: coupons, each_serializer: Api::Ecommerces::Coupons::Users::IndexSerializer,
           meta: pagination_dict(coupons), root: 'data', adapter: :json
  end

  def update
    Api::EcommerceOperations::CouponOperations::UserOperations::Update.new(actor, params).call
    render json: {}
  end
end
