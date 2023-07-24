# frozen_string_literal: true

class TourContracts::BusPatternContracts::Base < ApplicationContract
  attribute :name,           String
  attribute :capacity,       Integer

  validates :name, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 60 }
end
