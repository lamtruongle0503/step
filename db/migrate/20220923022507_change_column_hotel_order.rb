class ChangeColumnHotelOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_orders, :rooms
    add_reference :hotel_orders, :hotel_room
  end
end
