# frozen_string_literal: true

class EcommerceContracts::ProductContracts::CouponContracts::Base < ApplicationContract
  attribute :start_time, DateTime
  attribute :end_time,   DateTime
  attribute :price,      Float

  validates :price, presence: true
  validates :start_time, presence: true
  validates :end_time, presence:   true,
                       timeliness: {
                         on_or_after:         :start_time,
                         type:                :date,
                         on_or_after_message: I18n.t('.must_be_after_start_time'),
                       }
end
