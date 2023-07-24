# frozen_string_literal: true

class TourContracts::BusPatternContracts::Update < TourContracts::BusPatternContracts::Base
  attribute :record,      Tour::BusPattern
  attribute :map,         String
  attribute :seat_map,    String

  validates :name, uniqueness: { model: Tour::BusPattern }, unless: -> { name_valid? }
  validates :map,  presence: true

  def name_valid?
    record.name == name
  end

  def map
    seat_map.map.each do |column_seat_bus|
      column_seat_bus.each do |row_seat_bus|
        TourContracts::BusPatternContracts::SeatBusContracts::Base.new(row_seat_bus).valid!
      end
    end
  end
end
