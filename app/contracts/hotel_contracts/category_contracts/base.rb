# frozen_string_literal: true

class HotelContracts::CategoryContracts::Base < ApplicationContract
  attribute :code, String
  attribute :name, String

  validates :code, presence: true, uniqueness: { model: Hotel::Category }
  validates :name, presence: true
end
