# frozen_string_literal: true

class HotelContracts::OrderLogContracts::Base < ApplicationContract
  attribute :hotel_order_id, Integer
  attribute :plan, String
  attribute :hotel, String
  attribute :room, String
end
