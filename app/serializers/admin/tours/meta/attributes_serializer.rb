# frozen_string_literal: true

class Admin::Tours::Meta::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :start_date, :end_date, :code, :info_travel_fee,
             :prefectures, :type_locate

  def prefectures
    if object.type_locate == Tour::INDAY
      object.tour_start_locations.map do |tour_start_location|
        Admin::Tours::StartLocations::AttributesSerializer.new(tour_start_location).as_json
      end
    else
      object.tour_stay_departures.map do |tour_stay_departure|
        Admin::Tours::StayDepartures::AttributesSerializer.new(tour_stay_departure).as_json
      end
    end
  end
end
