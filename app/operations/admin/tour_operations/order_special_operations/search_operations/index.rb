# frozen_string_literal: true

class Admin::TourOperations::OrderSpecialOperations::SearchOperations::Index < ApplicationOperation
  attr_reader :tour, :order_special, :tour_orders

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
    @order_special = tour.tour_order_specials.find(params[:order_special_id])
    @tour_orders = tour.tour_orders
  end

  def call
    return [] unless tour_orders.present?

    case order_special.code
    when Tour::OrderSpecial::CXL
      tour_orders.by_status_cancel
    when Tour::OrderSpecial::CXL_WAITING
      tour_orders.by_status_cxl_waiting
    else
      tour_orders.by_status_full_place
    end
  end
end
