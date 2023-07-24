# frozen_string_literal: true

class Api::Tours::Indays::StartLocations::IndexSerializer < ApplicationSerializer
  attributes :start_locations

  def start_locations
    arr = []
    object.map(&:tour_start_locations).flatten.each do |start_location|
      start_location_name = start_location.address
      arr.push(start_location_name)
    end
    arr.uniq
  end
end
