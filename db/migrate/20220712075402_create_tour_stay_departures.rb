class CreateTourStayDepartures < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_stay_departures do |t|
      t.references :tour, null: false, foreign_key: true
      t.string :address
      t.date :setting_date
      t.integer :one_person_fee
      t.integer :two_people_fee
      t.integer :three_people_fee
      t.integer :four_people_fee

      t.timestamps
    end
  end
end
