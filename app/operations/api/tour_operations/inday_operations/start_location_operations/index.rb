# frozen_string_literal: true

class Api::TourOperations::IndayOperations::StartLocationOperations::Index < ApplicationOperation
  def call
    Tour.includes(tour_start_locations: :prefecture).references(tour_start_locations: :prefecture)
        .by_status_posted.where(
          'tours.end_date >= ? AND tours.type_locate = ? AND tour_start_locations.prefecture_id = ?',
          Date.current, Tour.type_locates[:inday], params[:prefecture_id]
        )
  end
end
