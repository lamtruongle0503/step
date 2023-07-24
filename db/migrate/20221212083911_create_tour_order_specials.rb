class CreateTourOrderSpecials < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_order_specials do |t|
      t.string :name
      t.string :code
      t.string :description
      t.integer :number_of_people
      t.string :capacity_pattern
      t.belongs_to :tour, foreign_key: true, index: true

      t.timestamps
    end
  end
end
