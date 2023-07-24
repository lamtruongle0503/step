# frozen_string_literal: true

class HotelContracts::CouponContracts::Base < ApplicationContract
  attribute :start_time, Date
  attribute :end_time,   Date
  attribute :price,      Float

  validates :start_time, :end_time, :price, presence: true
  validates :end_time, presence:   true,
                       timeliness: {
                         on_or_after:         :start_time,
                         type:                :date,
                         on_or_after_message: I18n.t('.must_be_after_start_time'),
                       }
end
