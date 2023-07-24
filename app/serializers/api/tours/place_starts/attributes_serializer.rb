# frozen_string_literal: true

class Api::Tours::PlaceStarts::AttributesSerializer < ApplicationSerializer
  attributes :id, :code, :prefecture_name, :tour_start_locations

  def prefecture_name
    return unless object.prefecture

    object.prefecture.name
  end

  def tour_start_locations
    if object.tour.inday?
      object.tour_start_locations.where('setting_date >= ?',
                                        Date.today).uniq(&:address).map do |start_location|
        Api::Tours::TourStartLocations::MetaSerializer.new(start_location).as_json
      end.compact
    else
      object.tour_stay_departures.where('setting_date >= ?',
                                        Date.today).uniq(&:address).map do |stay_departure|
        Api::Tours::StayDepartures::MetaSerializer.new(stay_departure).as_json
      end.compact
    end
  end
end
