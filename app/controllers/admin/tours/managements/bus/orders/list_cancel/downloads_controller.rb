# frozen_string_literal: true

class Admin::Tours::Managements::Bus::Orders::ListCancel::DownloadsController < ApiV1Controller
  before_action :authentication!

  def create
    data = Admin::TourOperations::BusInfoOperations::
           OrderOperations::DownloadOperations::Create.new(actor, params).call
    file_name = "tour_order_cancel_#{I18n.l(Time.now, format: :strftime)}.csv"
    send_data data.sjis_encode, type: I18n.t(:csv, scope: [:response_type]), filename: file_name
  end
end
