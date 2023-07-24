# frozen_string_literal: true

class Admin::TourOperations::OrderSpecialOperations::TemporaryOperations::Destroy < ApplicationOperation
  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
    @order_special = @tour.tour_order_specials.find(params[:order_special_id])
    @temporary = Tour::Temporary.find(params[:id])
  end

  def call
    @temporary.destroy!
  end
end
