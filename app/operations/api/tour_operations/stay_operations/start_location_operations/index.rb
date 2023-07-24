# frozen_string_literal: true

class Api::TourOperations::StayOperations::StartLocationOperations::Index < ApplicationOperation
  def call
    Tour.includes(tour_stay_departures: :prefecture).references(tour_stay_departures: :prefecture)
        .by_status_posted.where(
          'tours.end_date >= ? AND tours.type_locate = ? AND tour_stay_departures.prefecture_id = ?',
          Date.current, Tour.type_locates[:stay], params[:prefecture_id]
        )
  end
end
