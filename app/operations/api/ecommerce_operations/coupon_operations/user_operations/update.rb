# frozen_string_literal: true

class Api::EcommerceOperations::CouponOperations::UserOperations::Update < ApplicationOperation
  attr_reader :user, :coupon

  def initialize(actor, params)
    super
    @user = actor
    @coupon = @user.ecommerce_coupon_users.find_by!(coupon_id: params[:coupon_id])
  end

  def call
    coupon.update!(is_used: true)
  end
end
