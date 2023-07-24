class AddReferencesToTourStartPlace < ActiveRecord::Migration[6.1]
  def change
    add_reference :tour_start_locations , :tour_place_start
    add_reference :tour_stay_departures , :tour_place_start
    remove_reference :tour_start_locations, :tour, null: false, foreign_key: true
    remove_reference :tour_stay_departures, :tour, null: false, foreign_key: true
  end
end
