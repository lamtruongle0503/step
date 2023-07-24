class AddFieldHotelRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_rooms, :number_children, :integer
  end
end
