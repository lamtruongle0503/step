# frozen_string_literal: true

class HotelContracts::CancellationPolicyContracts::Base < ApplicationContract
  attribute :cxl_management_name, String
  attribute :date_free_cancellation, Integer
  attribute :is_use, Boolean

  validates :cxl_management_name, length: { maximum: 255 }, if: -> { date_free_cancellation }
  validates :date_free_cancellation, numericality: { only_integer: true }, length: { maximum: 15 },
                                    if: -> { date_free_cancellation }
  validates :is_use, inclusion: { in: [true, false] }, if: -> { is_use }
end
