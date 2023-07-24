# frozen_string_literal: true

class HotelContracts::OptionContracts::Base < ApplicationContract
  attribute :description, String
  attribute :is_use, Boolean
  attribute :management_name, String
  attribute :name, String
  attribute :price, Float
  attribute :unit, Integer
  attribute :created_at, DateTime
  attribute :updated_at, DateTime

  validates :unit, inclusion: { in: Hotel::Option.units }, if: -> { unit }
end
