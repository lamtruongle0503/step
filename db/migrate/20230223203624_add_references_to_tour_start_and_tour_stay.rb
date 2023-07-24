class AddReferencesToTourStartAndTourStay < ActiveRecord::Migration[6.1]
  def change
    add_reference :tour_start_locations, :tour, foreign_key: true, index: true
    add_reference :tour_stay_departures, :tour, foreign_key: true, index: true
  end
end
