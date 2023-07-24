# frozen_string_literal: true

class TourContracts::BusPatternContracts::Create < TourContracts::BusPatternContracts::Base
  validates :name, uniqueness: { model: Tour::BusPattern }
end
