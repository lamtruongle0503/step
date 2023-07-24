# frozen_string_literal: true

class Api::Tours::Stays::PlaceStarts::AttributesSerializer < ApplicationSerializer
  attributes :tour, :tour_place_starts

  def tour
    Api::Tours::Stays::IndexSerializer.new(object).as_json
  end

  def tour_place_starts
    object.tour_place_starts.map do |tour_place_start|
      Api::Tours::PlaceStarts::AttributesSerializer.new(tour_place_start).as_json
    end
  end
end
