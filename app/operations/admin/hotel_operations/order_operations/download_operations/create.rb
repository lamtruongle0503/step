# frozen_string_literal: true

require 'csv'

class Admin::HotelOperations::OrderOperations::DownloadOperations::Create < ApplicationOperation
  def call
    generate_csv
  end

  private

  def reservations
    @q = Hotel::Order.ransack(params[:q])
    @q.result.includes(:user, :coupon, :hotel).newest
  end

  def generate_csv
    CSV.generate do |csv|
      csv << I18n.t(:reservations, scope: [:headers])
      reservations.each do |record|
        csv << [record.hotel.name, record.order_no, I18n.l(record.created_at, format: :short),
                record.user&.full_name, record.user&.furigana, record.check_in,
                record.check_out, record.person_total, record.number_of_rooms,
                record.people_per_room, total_order(record), record.coupon&.price.to_i,
                record.used_points, record.total, format_rereservation_payment(record.payment_method)]
      end
    end
  end
end
