# frozen_string_literal: true

require 'tour/special_food'
class TourContracts::SpecialFoodContracts::Base < ApplicationContract
  attribute :name,    String
  attribute :price,   Float
  attribute :tour_id, Integer
  attribute :is_free, Boolean

  # validates :price, numericality: true, presence: true, if: -> { is_free }
  validates :tour_id, existence: Tour.name
end
