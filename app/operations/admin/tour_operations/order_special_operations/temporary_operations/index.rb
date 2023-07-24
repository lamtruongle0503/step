# frozen_string_literal: true

class Admin::TourOperations::OrderSpecialOperations::TemporaryOperations::Index < ApplicationOperation
  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
    @order_special = @tour.tour_order_specials.find(params[:order_special_id])
  end

  def call
    @q = @order_special.tour_temporaries.where(tour_id: @tour.id).ransack(params[:q])
    @q.result.page(params[:page])
  end
end
