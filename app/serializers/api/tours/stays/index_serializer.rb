# frozen_string_literal: true

class Api::Tours::Stays::IndexSerializer < Api::Tours::AttributeSerializer
  attributes :min_price, :max_price, :category_code, :destination, :stayed_nights,
             :stopover, :is_show_guide, :tour_guide, :meal_description, :tour_start_locations,
             :start_date, :end_date, :discount

  has_many :tour_options, serializer: Api::Tours::Stays::Options::AttributeSerializer
  has_many :hostels, serializer: Api::Tours::Stays::Hostels::AttributeSerializer
  has_one :tour_information, serializer: Api::Tours::Stays::Informations::AttributeSerializer

  def category_code
    object.tour_category.code
  end

  def min_price
    object.tour_information.min_price.to_f.round
  end

  def max_price
    object.tour_information.max_price.to_f.round
  end

  def tour_start_locations
    object.tour_stay_departures.includes(:tour, :prefecture).map do |tour_stay_departure|
      Api::Tours::Stays::StayDepartures::AttributeSerializer.new(tour_stay_departure).as_json
    end
  end
end
