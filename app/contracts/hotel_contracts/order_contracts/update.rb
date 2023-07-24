# frozen_string_literal: true

class HotelContracts::OrderContracts::Update < ApplicationContract
  attribute :status, String
  attribute :cancellation_type, String
  attribute :cancellation_other_reason, String
  attribute :cancellation_free, Boolean
  attribute :date_cancel, Date
  attribute :payment_status, String

  validates :status, inclusion: { in: Hotel::Order.statuses }, if: -> { status }
  validates :payment_status, inclusion: { in: Hotel::Order.payment_statuses }, if: -> { payment_status }
  validates :cancellation_type, inclusion: { in: Hotel::Order.cancellation_types },
                                if:        -> { cancellation_type }
end
