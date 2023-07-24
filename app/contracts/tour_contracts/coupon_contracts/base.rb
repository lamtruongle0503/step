# frozen_string_literal: true

class TourContracts::CouponContracts::Base < ApplicationContract
  attribute :start_time, Date
  attribute :end_time,   Date
  attribute :price,      Float
  attribute :tour_id,    Integer

  validates :end_time, timeliness: {
    on_or_after:         :start_time,
    type:                :date,
    on_or_after_message: I18n.t('.must_be_after_start_time'),
  }, if: -> { start_time.present? }
  validates :tour_id, presence: true, existence: Tour.name
end
