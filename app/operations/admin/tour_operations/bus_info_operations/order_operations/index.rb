# frozen_string_literal: true

class Admin::TourOperations::BusInfoOperations::OrderOperations::Index < ApplicationOperation
  def call
    authorize nil, Tour::Management::BusInfo::OrderPolicy

    Tour::Order.includes(
      :user,
      tour_order_accompanies: :tour_order,
    ).where(tour_bus_info_id: params[:bus_info_id], tour_id: params[:management_id])
               .where.not(status: [Tour::Order::FULL_PLACE, Tour::Order::CXL_WAITING]).newest
  end
end
