class CreateTourSpecialFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_special_foods do |t|
      t.references :tour, null: false, foreign_key: true
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
