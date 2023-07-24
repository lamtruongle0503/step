class CreateTourHotelCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_hotel_categories do |t|
      t.string :code
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
