# frozen_string_literal: true

class Admin::TourOperations::BusInfoOperations::DownloadOperations::GetSeatMap < ApplicationOperation
  def call
    bus_info = Tour::BusInfo.find(params[:bus_info_id])
    template = 'downloads/bus_seat_map.html.erb'
    HtmlToPdfService.new(template, bus_info).perform
  end
end
