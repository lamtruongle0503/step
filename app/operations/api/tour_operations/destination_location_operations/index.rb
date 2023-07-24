# frozen_string_literal: true

class Api::TourOperations::DestinationLocationOperations::Index < ApplicationOperation
  def call
    destinations = Tour.by_status_posted
                       .by_type_locate_and_address(params[:type_locate], params[:name], params[:address])
                       .where('tours.end_date >= ?', Date.current).distinct.pluck(:destination)
    {
      destinations: destinations_refactor(destinations).flatten.uniq,
    }
  end

  private

  def destinations_refactor(dests)
    dests.map do |dest|
      dest.split(/、|, |,|,、/)&.compact_blank
    end
  end
end
