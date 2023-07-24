# frozen_string_literal: true

class Admin::Ecommerces::Products::CouponsController < ApiV1Controller
  before_action :authentication!

  def index
    products = Admin::EcommerceOperations::ProductOperations::CouponOperations::Index
               .new(actor, params).call
    render json: products, each_serializer: Admin::Ecommerces::Products::Coupons::IndexSerializer,
           meta: pagination_dict(products), root: 'data', adapter: :json
  end
end
