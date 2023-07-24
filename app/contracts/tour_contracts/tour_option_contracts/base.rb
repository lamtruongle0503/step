# frozen_string_literal: true

class TourContracts::TourOptionContracts::Base < ApplicationContract
  attribute :name,    String
  attribute :price,   Float
  attribute :tour_id, Integer
  attribute :code,    String

  validates :tour_id, presence: true, existence: Tour.name
end
