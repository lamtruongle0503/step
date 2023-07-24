# frozen_string_literal: true

class Admin::TourOperations::OrderSpecialOperations::Index < ApplicationOperation
  attr_reader :tour, :order_specials

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
    @order_specials = @tour.tour_order_specials.includes(:tour)
  end

  def call
    return [] unless order_specials.present?

    order_specials
  end
end
