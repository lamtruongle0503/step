# frozen_string_literal: true

class HotelContracts::CancellationDetailContracts::Base < ApplicationContract
  attribute :name, String
  attribute :flg1, Integer
  attribute :flg2, Integer
  attribute :value, Float
  attribute :unit, Integer
  attribute :date_free_cancellation, Integer

  validates :name, presence: true, length: { maximum: 255 }
  validates :value, presence: true, numericality: { only_float: true }
  validates :unit, inclusion: { in: Hotel::CancellationDetail.units }, if: -> { unit }
  with_options length:       { maximum: 15 },
               numericality: { only_integer:             true,
                               greater_than_or_equal_to: 0,
                               less_than_or_equal_to:    :date_free_cancellation },
               presence:     true do
    validates :flg1, if: -> { flg1 }
    validates :flg2, if: -> { flg2 }
  end
end
