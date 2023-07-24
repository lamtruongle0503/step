# frozen_string_literal: true

class Admin::Tours::BusInfos::DownloadsController < ApiV1Controller
  before_action :authentication!

  def index
    data = Admin::TourOperations::BusInfoOperations::DownloadOperations::Create.new(actor, params).call
    file_name = "bus_info_#{params[:bus_info_id]}_#{I18n.l(Time.now, format: :strftime)}.pdf"
    send_data data, type: I18n.t(:pdf, scope: [:response_type]), filename: file_name
  end

  def seat_map
    data = Admin::TourOperations::BusInfoOperations::DownloadOperations::GetSeatMap.new(actor, params).call
    file_name = "bus_info_#{params[:bus_info_id]}_seat_map_#{I18n.l(Time.now, format: :strftime)}.pdf"
    send_data data, type: I18n.t(:pdf, scope: [:response_type]), filename: file_name
  end
end
