# frozen_string_literal: true

class Api::HotelOperations::OrderOperations::HistoryOperations::Index < ApplicationOperation
  def call
    actor.hotel_orders.includes(:hotel, :hotel_room).newest.page(params[:page])
  end
end
