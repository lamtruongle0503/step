# frozen_string_literal: true

class Admin::TourOperations::BusInfoOperations::OrderOperations::AccompanyOperations::Update <
      ApplicationOperation
  attr_reader :tour, :tour_bus_info, :tour_order, :tour_order_accompany

  def initialize(actor, params)
    super
    @tour                 = Tour.find(params[:management_id])
    @tour_bus_info        = tour.tour_bus_infos.find(params[:bus_info_id])
    @tour_order           = tour_bus_info.tour_orders.find(params[:order_id])
    @tour_order_accompany = tour_order.tour_order_accompanies.find(params[:id])
  end

  def call
    authorize nil, Tour::Management::OrderPolicy

    ActiveRecord::Base.transaction do
      return if tour_order_accompany.selected_seat.present?

      tour_order_accompany.update!(selected_seat: params[:selected_seat])
      update_name_in_seat(tour_bus_info.seats_map, tour_order_accompany)
    end
  end

  private

  def update_name_in_seat(seats_map, tour_order_accompany)
    seats_map.each do |seats|
      seats.each do |seat|
        next unless seat['name'] == tour_order_accompany.selected_seat

        seat['status'] = Tour::BusInfo::BOOKING
        seat.merge!(
          full_name: "#{tour_order_accompany.first_name}　#{tour_order_accompany.last_name}",
        )
      end
    end
    tour_bus_info.save!
  end
end
