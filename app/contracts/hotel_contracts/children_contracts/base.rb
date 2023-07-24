# frozen_string_literal: true

class HotelContracts::ChildrenContracts::Base < ApplicationContract
  attribute :capacity, Integer
  attribute :fee, Integer
  attribute :is_accept, Integer
  attribute :name, Integer
  attribute :unit, Integer
  attribute :created_at, DateTime
  attribute :updated_at, DateTime
  attribute :hotel_id, Integer
  attribute :code, String

  validates :unit, inclusion: { in: (0..1) }, if: -> { unit }
  validates :capacity, inclusion: { in: (0..1) }, if: -> { capacity }
  validates :is_accept, inclusion: { in: (0..2) }, if: -> { is_accept }
  validates :fee, length: { maximum: 15 }, numericality: { only_integer: true, greater_than_or_equal_to: 0 },
            if: -> { fee }
  validates :code, presence: true, uniqueness: { model: Hotel::ChildrenInfo, scope: :hotel_id }
end
