# frozen_string_literal: true

class Api::EcommerceOperations::CouponOperations::UserOperations::Create < ApplicationOperation
  attr_reader :user, :coupon

  def initialize(actor, params)
    super
    @user = actor
    @coupon = Coupon.find(params[:coupon_id])
  end

  def call
    # return if EcommerceCouponUser.exists?(user_id: @user.id, coupon_id: @coupon.id)

    EcommerceContracts::CouponContracts::Create.new(user_id: @user.id, coupon_id: @coupon.id).valid!
    user.ecommerce_coupon_users.create!(coupon: coupon)
  end
end
