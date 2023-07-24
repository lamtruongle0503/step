class CreateTourPlaceStarts < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_place_starts do |t|
      t.belongs_to :tour, foreign_key: true
      t.belongs_to :prefecture, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
