# frozen_string_literal: true

class TourCouponContracts::Base < ApplicationContract
  attribute :code,       String
  attribute :start_time, Date
  attribute :end_time,   Date
  validates :start_time, presence: true

  validates :end_time, presence:   true,
                       timeliness: {
                         on_or_after:         :start_date,
                         type:                :date,
                         on_or_after_message: I18n.t('.must_be_after_start_date'),
                       }
end
