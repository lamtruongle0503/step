class ChangeTourHotelCategoriesToHotelCategories < ActiveRecord::Migration[6.1]
  def change
    rename_table :tour_hotel_categories, :hotel_categories
  end
end
