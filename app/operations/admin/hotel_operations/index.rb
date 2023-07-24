# frozen_string_literal: true

class Admin::HotelOperations::Index < ApplicationOperation
  def call
    @q = Hotel.ransack(params[:q])
    @q.result.includes(:prefecture, :area_setting, :hotel_category,
                       coupons: :assets).newest.page(params[:page])
  end
end
