# frozen_string_literal: true

class Api::Tours::Stays::ShowSerializer < ApplicationSerializer
  attr_reader :tour_start_location_ids

  attributes :id, :code, :name, :images, :videos, :title, :start_date, :end_date, :destination,
             :tour_guide, :is_show_guide, :meal_description, :scheduler, :sight_seeing, :note, :options,
             :calendar, :hotel_description, :stopover, :transport_used, :min_number_participant,
             :info_travel_fee, :plan_implement, :tour_start_locations, :max_price, :min_price,
             :stayed_nights, :discount, :tour_bus_infos

  belongs_to :tour_category, serializer: Api::Tours::TourCategories::MetaSerializer
  has_one :tour_information, serializer: Api::Tours::Stays::Informations::AttributeSerializer
  has_many :assets, serializer: Assets::AttributesSerializer
  has_many :hostels, serializer: Api::Tours::Stays::Hostels::AttributeSerializer

  def initialize(object, options = {})
    super
    @tour_start_location_ids = object.tour_place_starts.find(options[:tour_place_start_id])
                                     .tour_stay_departures.where(address: options[:address])
                                     .pluck(:id)
  end

  def tour_bus_infos
    object.tour_bus_infos.includes(:tour, :tour_stay_departure).by_departure_date_asc.map do |tour_bus_info|
      next unless tour_start_location_ids.include?(tour_bus_info.tour_stay_departure_id)

      Api::Tours::BusInfos::AttributesSerializer.new(tour_bus_info).as_json
    end.compact
  end

  def min_price
    object.tour_information.min_price.to_f.round
  end

  def max_price
    object.tour_information.max_price.to_f.round
  end

  def images
    object.assets.select { |asset_video| asset_video.type == Asset::T_IMAGE_INTRO }
  end

  def videos
    object.assets.select { |asset_video| asset_video.type == Asset::T_VIDEO_INTRO }
  end

  def calendar; end

  def tour_start_locations
    object.tour_stay_departures.includes(:tour, :prefecture).map do |tour_stay_departure|
      next unless tour_start_location_ids.include?(tour_stay_departure.id)

      Api::Tours::Stays::StayDepartures::AttributeSerializer.new(tour_stay_departure).as_json
    end.compact
  end
end
