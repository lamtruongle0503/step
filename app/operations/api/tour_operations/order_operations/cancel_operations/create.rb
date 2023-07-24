# frozen_string_literal: true

require 'tour/order'
class Api::TourOperations::OrderOperations::CancelOperations::Create < ApplicationOperation
  attr_reader :tour_order, :user, :tour_cancellation_details, :total_price

  def initialize(actor, params)
    super
    @user                      = actor
    @tour_order                = user.tour_orders.find(params[:tour_order_id])
    @total_price               = tour_order.total
    @tour_cancellation_details = tour_order.tour.tour_cancellation_policy.tour_cancellation_details
  end

  def call
    ActiveRecord::Base.transaction do
      if tour_order.status == Tour::Order::CANCEL
        return raise BadRequestError,
                     tour_order: I18n.t('order_tours.tours.book_cancelled')
      end
      update_bus_infos_when_cancel(tour_order)
      refund_purchased_amount(tour_order, total_price, tour_cancellation_details)
    end
  end
end
