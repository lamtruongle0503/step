# frozen_string_literal: true

class TourContracts::OrderContracts::Update < ApplicationContract
  attribute :status, String

  validates :status, inclusion: { in: Tour::Order.statuses.keys }, if: -> { status }
end
