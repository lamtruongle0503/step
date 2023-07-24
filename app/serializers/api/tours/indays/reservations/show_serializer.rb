# frozen_string_literal: true

class Api::Tours::Indays::Reservations::ShowSerializer < ApplicationSerializer
  attributes :id, :name, :code, :title, :tax, :bus_seats, :date_of_cancellation_fee,
             :point_receive_rate, :point_bonus_rate, :other_fee, :coupons,
             :start_date, :end_date

  has_many :tour_special_foods, serializer: Api::Tours::TourSpecialFoods::AttributesSerializer
  belongs_to :tour_cancellation_policy, serializer: Api::Tours::CancellationPolicies::AttributesSerializer

  attr_reader :departure_date, :total_person, :tour_info

  def initialize(object, options = {})
    super
    @departure_date = options[:departure_date]
    @total_person   = options[:total_person].to_i
    @tour_infos = object.tour_bus_infos.includes(:tour, :tour_stay_departure)
                        .by_departure_date(departure_date)
                        .where(tour_start_location_id: options[:tour_start_location_id])
                        .order(:created_at, :available_seats)

    @tour_info = @tour_infos.detect { |obj| obj.available_seats >= total_person }
  end

  def bus_seats
    Api::Tours::BusInfos::AttributesSerializer.new(tour_info).as_json if tour_info
  end

  def coupons
    coupons = object.coupons.find_coupon_by_tour.tour_available
    coupons.map { |coupon| Api::Coupons::AttributeSerializer.new(coupon).as_json }
  end

  def date_of_cancellation_fee
    return unless tour_info

    cal_date_of_cancellation(tour_info.departure_date,
                             object.tour_cancellation_policy.tour_cancellation_details)
  end
end
