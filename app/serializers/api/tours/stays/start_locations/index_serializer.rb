# frozen_string_literal: true

class Api::Tours::Stays::StartLocations::IndexSerializer < ApplicationSerializer
  attributes :start_locations

  def start_locations
    arr = []
    object.map(&:tour_stay_departures).flatten.each do |start_location|
      start_location_name = start_location.address
      arr.push(start_location_name)
    end
    arr.uniq
  end
end
