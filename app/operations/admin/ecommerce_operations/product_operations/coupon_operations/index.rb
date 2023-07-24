# frozen_string_literal: true

class Admin::EcommerceOperations::ProductOperations::CouponOperations::Index < ApplicationOperation
  def call
    Product.includes(:coupon).page(params[:page])
  end
end
