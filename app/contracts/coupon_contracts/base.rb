# frozen_string_literal: true

class CouponContracts::Base < ApplicationContract
  attribute :start_time,     Date
  attribute :end_time,       Date
  attribute :publish_date,   Date
  attribute :is_notice,      Boolean
  attribute :prefecture_ids, Array
  attribute :tour_id,        Integer

  validates :prefecture_ids, existences: Prefecture.name
  validates :start_time, presence: true
  validates :end_time, presence:   true,
                       timeliness: {
                         on_or_after:         :start_time,
                         type:                :date,
                         on_or_after_message: I18n.t('.must_be_after_start_time'),
                       }
  validates :publish_date, presence: true
end
