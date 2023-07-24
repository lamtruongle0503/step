# frozen_string_literal: true

class Api::Tours::Indays::Info::ShowSerializer < ApplicationSerializer
  attributes :id, :name, :title, :code, :tour_start_locations, :date_of_cancellation_fee,
             :start_date, :end_date

  attr_reader :start_location, :setting_date

  def initialize(object, options = {})
    super
    @setting_date   = options[:setting_date]
    @start_location = object.tour_start_locations.find_by(id: options[:start_location_id])
  end

  has_one :tour_information, serializer: Api::Tours::Indays::Informations::AttributesSerializer
  belongs_to :tour_cancellation_policy, serializer: Api::Tours::CancellationPolicies::AttributesSerializer

  def tour_start_locations
    return unless start_location

    Api::Tours::TourStartLocations::MetaSerializer.new(start_location).as_json
  end

  def date_of_cancellation_fee
    cal_date_of_cancellation(setting_date.to_date,
                             object.tour_cancellation_policy.tour_cancellation_details)
  end
end
