# frozen_string_literal: true

class Api::Tours::Indays::ShowSerializer < ApplicationSerializer
  attributes :id, :code, :name, :images, :videos, :title, :start_date, :end_date, :destination,
             :tour_guide, :is_show_guide, :meal_description, :scheduler, :sight_seeing, :note, :options,
             :stopover, :max_price, :min_price, :transport_used, :min_number_participant, :info_travel_fee,
             :plan_implement, :discount, :tour_bus_infos
  attr_reader :adult_dayoff_amount_fee, :adult_weekday_amount_fee, :tour_start_location_ids

  def initialize(object, options = {})
    super
    @adult_dayoff_amount_fee  = object.tour_information.adult_dayoff_amount
    @adult_weekday_amount_fee = object.tour_information.adult_weekday_amount
    @tour_start_location_ids  = object.tour_place_starts.find(options[:tour_place_start_id])
                                      .tour_start_locations.where(address: options[:address])
                                      .pluck(:id)
  end

  belongs_to :tour_category, serializer: Api::Tours::TourCategories::MetaSerializer
  has_one :tour_information, serializer: Api::Tours::Indays::Informations::AttributesSerializer
  has_many :tour_start_locations, serializer: Api::Tours::Indays::StartLocations::AttributeSerializer

  def tour_bus_infos
    object.tour_bus_infos.includes(:tour, :tour_start_location).by_departure_date_asc.map do |tour_bus_info|
      next unless tour_start_location_ids.include?(tour_bus_info.tour_start_location_id)

      Api::Tours::BusInfos::AttributesSerializer.new(tour_bus_info).as_json
    end.compact
  end

  def tour_start_locations
    object.tour_start_locations.where(id: tour_start_location_ids)
  end

  def images
    object.assets.select { |asset_video| asset_video.type == Asset::T_IMAGE_INTRO }
  end

  def videos
    object.assets.select { |asset_video| asset_video.type == Asset::T_VIDEO_INTRO }
  end

  def min_price
    [adult_dayoff_amount_fee, adult_weekday_amount_fee].min.to_f.round
  end

  def max_price
    [adult_dayoff_amount_fee, adult_weekday_amount_fee].max.to_f.round
  end
end
