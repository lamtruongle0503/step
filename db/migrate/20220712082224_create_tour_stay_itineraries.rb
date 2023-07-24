class CreateTourStayItineraries < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_stay_itineraries do |t|
      t.references :tour, null: false, foreign_key: true
      t.integer :date_index, index: true
      t.integer :index, index: true
      t.string :description

      t.timestamps
    end
  end
end
