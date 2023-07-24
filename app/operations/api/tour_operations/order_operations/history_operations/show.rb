# frozen_string_literal: true

require 'tour/order'
class Api::TourOperations::OrderOperations::HistoryOperations::Show < ApplicationOperation
  def call
    actor.tour_orders.find(params[:id])
  end
end
