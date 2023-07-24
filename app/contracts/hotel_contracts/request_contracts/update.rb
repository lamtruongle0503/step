# frozen_string_literal: true

class HotelContracts::RequestContracts::Update < HotelContracts::RequestContracts::Base
  attribute :status, Integer

  validates :status, inclusion: { in: Hotel::Request.statuses }, if: -> { status }
end
