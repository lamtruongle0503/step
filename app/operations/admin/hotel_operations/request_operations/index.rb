# frozen_string_literal: true

class Admin::HotelOperations::RequestOperations::Index < ApplicationOperation
  def call
    authorize nil, Hotel::RequestPolicy

    @q = Hotel::Request.ransack(params[:q])
    @q.result(distinct: true).includes(:hotel, :hotel_room).newest.page(params[:page])
  end
end
