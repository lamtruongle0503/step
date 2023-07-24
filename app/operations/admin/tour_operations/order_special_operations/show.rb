# frozen_string_literal: true

class Admin::TourOperations::OrderSpecialOperations::Show < ApplicationOperation
  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
    @order_special = @tour.tour_order_specials.find(params[:id])
  end

  def call
    @order_special
  end
end
