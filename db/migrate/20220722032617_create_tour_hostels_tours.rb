class CreateTourHostelsTours < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_hostels_tours do |t|
      t.references :tour, foreign_key: true
      t.references :tour_hostel, foreign_key: true
      t.timestamps
    end
  end
end
