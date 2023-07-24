class AddColumnHotelDescriptionToTours < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :hotel_description, :string
  end
end
