# frozen_string_literal: true

require 'tour/order'
class Api::TourOperations::OrderOperations::HistoryOperations::Index < ApplicationOperation
  def call
    @q = actor.tour_orders.includes([:tour_order_log, {
                                      tour: :assets, tour_bus_info: %i[tour_start_location
                                                                       tour_stay_departure]
                                    }]).ransack(params[:q])
    @q.result(distinct: true).newest.page(params[:page])
  end
end
