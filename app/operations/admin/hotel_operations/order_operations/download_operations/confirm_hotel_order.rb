# frozen_string_literal: true

require 'csv'

class Admin::HotelOperations::OrderOperations::DownloadOperations::ConfirmHotelOrder < ApplicationOperation
  attr_reader :hotel_order

  def initialize(actor, params)
    super
    @hotel_order = Hotel::Order.find(params[:order_id])
  end

  def call
    generate_csv
  end

  private

  def generate_csv # rubocop:disable Metrics/AbcSize
    CSV.generate do |csv|
      csv << I18n.t(:reservations, scope: [:headers])
      csv << [hotel_order.hotel.name,
              hotel_order.order_no,
              I18n.l(hotel_order.created_at, format: :short),
              hotel_order.user&.full_name,
              hotel_order.user&.furigana,
              hotel_order.check_in,
              hotel_order.check_out,
              (hotel_order.person_total / hotel_order.total_room),
              hotel_order.total_room,
              hotel_order.person_total,
              total_amount,
              hotel_order.coupon&.price.to_i,
              hotel_order.used_points,
              hotel_order.total,
              format_rereservation_payment(hotel_order.payment_method),
              format_status_hotel_order(hotel_order.status)]
    end
  end

  def total_amount
    total_pre = hotel_order.total + hotel_order.used_points
    return total_pre unless hotel_order.coupon

    total_pre + hotel_order.coupon.price.round
  end
end
