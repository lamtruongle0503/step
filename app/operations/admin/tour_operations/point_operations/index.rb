# frozen_string_literal: true

require 'tour/order'

class Admin::TourOperations::PointOperations::Index < ApplicationOperation
  def call
    if params[:tour_order_id]
      Tour::Order.where(id: params[:tour_order_id]).includes(:user, :tour, :tour_bus_info)
    else
      tour = Tour.find(params[:tour_id])
      bus = tour.tour_bus_infos.find(params[:tour_bus_id])
      bus.tour_orders.includes(:user, :tour, :tour_bus_info)
    end
  end
end
