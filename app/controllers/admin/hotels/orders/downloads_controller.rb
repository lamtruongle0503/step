# frozen_string_literal: true

class Admin::Hotels::Orders::DownloadsController < ApiV1Controller
  before_action :authentication!

  def create
    data = Admin::HotelOperations::OrderOperations::DownloadOperations::Create.new(actor, params).call

    file_name = "reservations_#{I18n.l(Time.now, format: :strftime)}.csv"
    send_data data.sjis_encode, type: I18n.t(:csv, scope: [:response_type]), filename: file_name
  end

  def index
    data = Admin::HotelOperations::OrderOperations::DownloadOperations::Index.new(actor, params).call
    file_name = "reservation_statistics_#{I18n.l(Time.now, format: :strftime)}.pdf"
    send_data data, type: I18n.t(:pdf, scope: [:response_type]), filename: file_name
  end

  def confirm_hotel_order
    data = Admin::HotelOperations::OrderOperations::DownloadOperations::ConfirmHotelOrder
           .new(actor, params).call

    file_name = "hotel_reservations_#{I18n.l(Time.now, format: :strftime)}.csv"
    send_data data.sjis_encode, type: I18n.t(:csv, scope: [:response_type]), filename: file_name
  end
end
