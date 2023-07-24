# frozen_string_literal: true

class TourContracts::CancellationDetailContracts::Base < ApplicationContract
  attribute :flg1, Integer
  attribute :name, String
  attribute :flg2, Integer
  attribute :unit, Integer
  attribute :value, Float

  validates :name, presence: true
  validates :value, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :unit, inclusion: { in: Tour::CancellationDetail.units.keys }, if: -> { unit }
  with_options length: { maximum: 15 }, presence: true do
    validates :flg1, if: -> { flg1 }
    validates :flg2, if: -> { flg2 }
  end
end
