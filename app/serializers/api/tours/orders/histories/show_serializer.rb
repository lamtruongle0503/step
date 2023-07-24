# frozen_string_literal: true

class Api::Tours::Orders::Histories::ShowSerializer < ApplicationSerializer
  attributes :id, :order_no, :created_at, :payment_status, :memo, :initial_price, :total,
             :departure_date, :depature_time, :coupon_discount, :used_points, :room,
             :total_price_special_food, :total_price_stay_departure, :total_tour,
             :total_tour_bus_seat_map, :total_tour_option, :price_tax, :type,
             :date_of_cancellation_fee, :status, :coupon_id, :payment_method,
             :is_seats_bus_free, :received_bonus_point, :received_point, :invoice_desc,
             :address, :bus_no, :concentrate_time, :seat_map, :selected_seats

  belongs_to :user, serializer: Api::Users::Histories::AttributesSerializer
  has_one :tour_order_log, serializer: Api::Tours::Orders::OrderLog::AttributeSerializer
  has_many :tour_order_accompanies, serializer: Api::Tours::Orders::OrderAccompanies::AttributeSerializer

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
    (object.initial_price * object.tour_order_log.tour['tax'] / 100).to_f.round
  end

  def type
    object.tour.class.name
  end

  def initial_price
    object.initial_price.to_f.round
  end

  def total
    object.total.to_f.round
  end

  def address
    if object.tour.inday?
      object.tour_bus_info.tour_start_location.address
    else
      object.tour_bus_info.tour_stay_departure.address
    end
  end

  def bus_no
    object.tour_bus_info.bus_no
  end

  def seat_map
    Api::Tours::BusInfos::AttributesSerializer.new(object.tour_bus_info).as_json
  end

  def selected_seats
    arr_selected_seats = []
    selected_seats_name = object.tour_order_accompanies.pluck(:selected_seat)
    object.tour_bus_info.seats_map.each_with_index do |seat_maps, index|
      seat_maps.each do |seat_map|
        if selected_seats_name.include?(seat_map['name'])
          arr_selected_seats << seat_map.merge(index_column: index)
        end
      end
    end
    arr_selected_seats
  end
end
