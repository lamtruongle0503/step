# frozen_string_literal: true

class Api::TourOperations::StayOperations::PrefectureOperations::Index < ApplicationOperation
  def call
    Tour.includes(tour_start_locations: :prefecture)
        .by_status_posted.by_end_date(Date.current, Tour.type_locates[Tour::STAY])
  end
end
