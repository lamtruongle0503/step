# frozen_string_literal: true

class Api::Tours::Stays::Info::ShowSerializer < ApplicationSerializer
  attributes :id, :code, :name, :title, :start_date, :end_date, :destination,
             :meal_description, :hotel_description, :stayed_nights, :tour_start_locations,
             :date_of_cancellation_fee

  attr_reader :tour_stay_departure, :setting_date

  def initialize(object, options = {})
    super
    @setting_date = options[:setting_date]
    @tour_stay_departure = object.tour_stay_departures.find_by(id: options[:start_location_id])
  end

  has_many :hostels, serializer: Api::Tours::Stays::Hostels::AttributeSerializer
  has_one :tour_information, serializer: Api::Tours::TourInformations::AttributesSerializer
  has_many :assets, serializer: Assets::AttributesSerializer
  belongs_to :tour_cancellation_policy, serializer: Api::Tours::CancellationPolicies::AttributesSerializer

  def tour_start_locations
    return unless tour_stay_departure

    Api::Tours::StayDepartures::Info::AttributeSerializer.new(tour_stay_departure).as_json
  end

  def date_of_cancellation_fee
    cal_date_of_cancellation(setting_date.to_date,
                             object.tour_cancellation_policy.tour_cancellation_details)
  end
end
