# frozen_string_literal: true

require 'tour/place_start'
class TourContracts::PlaceStartContracts::Base < ApplicationContract
  attribute :code,          String
  attribute :tour_id,       Integer
  attribute :prefecture_id, Integer

  validates :tour_id, presence: true, existence: Tour.name
  validates :prefecture_id, presence: true, existence: Prefecture.name
  validates :code, presence: true
end
