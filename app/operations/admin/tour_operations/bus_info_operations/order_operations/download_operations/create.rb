# frozen_string_literal: true

require 'tour/bus_info'
class Admin::TourOperations::BusInfoOperations::OrderOperations::DownloadOperations::Create <
      ApplicationOperation
  attr_reader :tour, :tour_orders

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:management_id])
    @tour_orders = tour.tour_orders.by_status_cancel
  end

  def call
    return unless tour_orders.present?

    generate_csv
  end

  private

  def generate_csv # rubocop:disable Metrics/PerceivedComplexity, Metrics/AbcSize
    CSV.generate do |csv|
      csv << I18n.t(:tour_order_cancel, scope: [:headers])
      tour_orders.includes(:tour_order_accompanies, :tour_bus_info).each do |tour_order|
        tour_order.tour_order_accompanies.each do |accompany|
          next unless accompany.is_user.present? || accompany.is_owner.present?

          csv << [
            accompany.full_name, accompany.furigana, accompany.post_code, accompany.address1,
            accompany.address2, accompany.phone_number, accompany.telephone, tour_order.departure_date,
            tour_order.tour_bus_info&.tour_stay_departure&.name ||
            tour_order.tour_bus_info&.tour_start_location&.name,
            tour_order.tour_bus_info.bus_no, tour_order.tour_order_accompanies.size,
            tour_order.initial_price, tour_order.coupon_discount, tour_order.used_points,
            tour_order.total, tour_order.payment_method, tour_order.status, nil, tour_order.memo,
            tour_order.date_of_cancellation, tour_order.cancellation_fee,
            (tour_order.total * tour_order.cancellation_fee.to_f / 100).round, 0, tour_order.price_refund,
            tour_order.refund_comfirm_date, tour_order.estimate_payment_amount,
            tour_order.payment_confirmation_date
          ]
        end
      end
    end
  end
end
