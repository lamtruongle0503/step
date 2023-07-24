# frozen_string_literal: true

class Admin::Tours::Orders::ShowSerializer < ApplicationSerializer
  attributes :id, :order_no, :created_at, :payment_status, :status, :memo, :initial_price, :total,
             :departure_date, :coupon_discount, :used_points, :room, :total_price_special_food,
             :total_tour_option, :payment_method, :price_tax, :payment_note, :received_bonus_point,
             :received_point, :total_price_stay_departure, :total_tour, :total_tour_bus_seat_map,
             :date_of_cancellation, :cancellation_fee, :price_cancellation, :price_refund,
             :refund_comfirm_date, :cancellation_free, :coupon_id, :is_seats_bus_free,
             :list_cancellation_fee, :estimate_payment_amount, :estimate_payment_confirmation_date,
             :payment_confirmation_date, :invoice_desc, :is_cancellation_free

  belongs_to :user, serializer: Admin::Tours::Orders::Users::AttributesSerializer
  belongs_to :tour_bus_info, serializer: Admin::Tours::Orders::BusInfos::IndexSerializer
  has_one :tour_order_log, serializer: Admin::Tours::Orders::OrderLog::AttributesSerializer
  has_many :tour_order_accompanies, serializer: Admin::Tours::Orders::OrderAccompanies::AttributesSerializer

  def list_cancellation_fee
    object.tour.tour_cancellation_policy.tour_cancellation_details.map do |tour_cancellation_detail|
      Admin::Tours::CancellationDetails::IndexSerializer.new(tour_cancellation_detail).as_json
    end
  end

  def created_at
    object.created_at.to_date
  end

  def total_price_special_food
    object.total_price_special_food.to_f.round
  end

  def total_price_stay_departure
    object.total_price_stay_departure.to_f.round
  end

  def total_tour
    object.total_tour.to_f.round
  end

  def total_tour_bus_seat_map
    object.total_tour_bus_seat_map.to_f.round
  end

  def total_tour_option
    object.total_tour_option.to_f.round
  end

  def price_tax
    (object.tour_order_log.tour['tax'] * object.initial_price / 100).to_f.round
  end

  def price_cancellation
    return unless object.cancellation_fee

    (object.total * object.cancellation_fee / 100).to_f.round
  end

  def initial_price
    object.initial_price.to_f.round
  end

  def total
    object.total.to_f.round
  end

  def coupon_discount
    object.coupon_discount.to_f.round
  end

  def price_refund
    return 0 unless object.payment_status == Tour::Order::REFUNED

    object.price_refund.to_f.round
  end
end
