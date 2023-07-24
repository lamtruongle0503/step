# frozen_string_literal: true

class Admin::HotelOperations::OrderOperations::Index < ApplicationOperation
  def call
    authorize nil, Hotel::OrderPolicy

    @q = Hotel::Order.ransack(params[:q])
    @q.result.includes(:user, :coupon, :hotel).newest.page(params[:page])
  end
end
