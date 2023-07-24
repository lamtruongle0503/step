# frozen_string_literal: true

class TourContracts::BusInfoContracts::Base < ApplicationContract
  attribute :departure_date,         Date
  attribute :day_of_week,            String
  attribute :is_weekend,             Integer
  attribute :bus_no,                 String
  attribute :tour_bus_pattern_id,    Integer
  attribute :tour_start_location_id, Integer
  attribute :concentrate_time,       String
  attribute :departure_time,         String
  attribute :tour_place_start_id,    Integer

  validates :departure_date, presence: true
  validates :day_of_week,    presence: true
  validates :bus_no,         presence: true
  validates :is_weekend,     inclusion: { in: Tour::BusInfo.is_weekends }
  validates :tour_bus_pattern_id, existence: Tour::BusPattern.name
  validates :tour_place_start_id, existence: Tour::PlaceStart.name
end
