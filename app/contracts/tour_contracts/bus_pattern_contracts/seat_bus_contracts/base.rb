# frozen_string_literal: true

class TourContracts::BusPatternContracts::SeatBusContracts::Base < ApplicationContract
  attribute :status, Integer
  attribute :type,   Integer
  attribute :row,    Integer
  attribute :name,   String

  validates :status, inclusion: { in: Tour::BusPattern.statuses }, if: -> { status }
  validates :type, inclusion: { in: Tour::BusPattern.types }, if: -> { type }
end
