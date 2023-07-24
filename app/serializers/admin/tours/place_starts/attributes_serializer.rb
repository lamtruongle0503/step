# frozen_string_literal: true

class Admin::Tours::PlaceStarts::AttributesSerializer < ApplicationSerializer
  attributes :id, :code, :prefecture, :tour_start_locations, :tour_stay_departures

  def prefecture
    Admin::Prefectures::AttributesSerializer.new(object.prefecture).as_json
  end

  def tour_start_locations
    object.tour_start_locations.map do |tour_start_location|
      Admin::Tours::StartLocations::AttributesSerializer.new(tour_start_location).as_json
    end
  end

  def tour_stay_departures
    object.tour_stay_departures.map do |tour_stay_departure|
      Admin::Tours::StayDepartures::AttributesSerializer.new(tour_stay_departure).as_json
    end
  end
end
