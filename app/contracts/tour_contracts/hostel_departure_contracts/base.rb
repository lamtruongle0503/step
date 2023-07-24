# frozen_string_literal: true

class TourContracts::HostelDepartureContracts::Base < ApplicationContract
  attribute :note,            String
  attribute :option_ids,      Array[String]
  attribute :tour_hostel_id,  Integer
  attribute :tour_id,         Integer

  validates :tour_hostel_id, presence: true, existence: Tour::Hostel.name
  validates :tour_id, presence: true, existence: Tour.name
end
