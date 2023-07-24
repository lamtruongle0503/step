# frozen_string_literal: true

class Admin::TourOperations::BusInfoOperations::DownloadOperations::Create < ApplicationOperation
  def call
    bus = Tour::BusInfo.includes(:tour, :tour_start_location, :tour_stay_departure,
                                 tour_orders: [:tour_order_log, {
                                   tour_order_accompanies: %i[tour_special_food tour_option],
                                 }])
                       .find(params[:bus_info_id])
    template = 'downloads/inday_bus.html.erb'
    template = 'downloads/stay_bus.html.erb' if bus.tour.stay?
    HtmlToPdfService.new(template, bus).perform
  end
end
