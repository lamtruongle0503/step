# frozen_string_literal: true

class Api::HotelOperations::RankingOperations::Index < ApplicationOperation
  def call
    Hotel.includes(:hotel_options, :assets).ranking.limit(10)
  end
end
