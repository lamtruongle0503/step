# frozen_string_literal: true

class TourContracts::OrderContracts::Base < ApplicationContract
  attribute :cancellation_fee,            Float
  attribute :cancellation_free,           Boolean
  attribute :coupon_discount,             Float
  attribute :date_of_cancellation,        Date
  attribute :departure_date,              Date
  attribute :departure_start_location,    String
  attribute :discount_amount,             Integer
  attribute :initial_price,               Float
  attribute :invoice_desc,                String
  attribute :memo,                        String
  attribute :number_people,               Integer
  attribute :order_no,                    String
  attribute :payment_method,              Integer
  attribute :payment_note,                String
  attribute :payment_status,              Integer
  attribute :received_bonus_point,        Integer
  attribute :received_point,              Integer
  attribute :room,                        String
  attribute :seat_selection,              String
  attribute :status,                      Integer
  attribute :total,                       Float
  attribute :total_price_special_food,    Float
  attribute :total_price_stay_departure,  Float
  attribute :total_tour,                  Float
  attribute :total_tour_bus_seat_map,     Float
  attribute :total_tour_option,           Float
  attribute :used_points,                 Integer
  attribute :coupon_id,                   Integer
  attribute :tour_bus_info_id,            Integer
  attribute :tour_id,                     Integer
  attribute :tour_stay_departure_id,      Integer
  attribute :user_id,                     Integer
  attribute :is_seats_bus_free,           Integer
  attribute :price_seat,                  String
  attribute :point,                       Integer

  validate  :used_point_must_less_than_or_equal_point
  validates :status, inclusion: { in: Tour::Order.statuses.keys }, if: -> { status }
  validates :payment_method, inclusion: { in: Tour::Order.payment_methods.keys }, if: -> { payment_method }
  validates :payment_status, inclusion: { in: Tour::Order.payment_statuses.keys }, if: -> { payment_status }
  validates :is_seats_bus_free, inclusion: { in: Tour::Order.is_seats_bus_frees.keys },
                                if:        -> { is_seats_bus_free }

  def used_point_must_less_than_or_equal_point
    return if used_points <= point && used_points >= 0

    errors.add :use_point, I18n.t('order_tours.use_point.used_point_must_less_than_or_equal_point')
  end
end
