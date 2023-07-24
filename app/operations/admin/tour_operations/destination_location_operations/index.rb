# frozen_string_literal: true

class Admin::TourOperations::DestinationLocationOperations::Index < ApplicationOperation
  def call
    destinations = Tour.where('tours.end_date >= ?', Date.current).distinct.pluck(:destination)
    destinations_refactor(destinations).flatten.uniq
  end

  private

  def destinations_refactor(dests)
    dests.map do |dest|
      dest.split(/、|, |,|,、/)&.compact_blank
    end
  end
end
