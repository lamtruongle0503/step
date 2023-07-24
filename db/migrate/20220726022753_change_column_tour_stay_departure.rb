class ChangeColumnTourStayDeparture < ActiveRecord::Migration[6.1]
  def change
    remove_column :tour_stay_departures, :two_people_fee, :integer
    remove_column :tour_stay_departures, :three_people_fee, :integer
    remove_column :tour_stay_departures, :four_people_fee, :integer

    add_column :tour_stay_departures, :two_person_fee, :float
    add_column :tour_stay_departures, :three_person_fee, :float
    add_column :tour_stay_departures, :four_person_fee, :float
  end
end
