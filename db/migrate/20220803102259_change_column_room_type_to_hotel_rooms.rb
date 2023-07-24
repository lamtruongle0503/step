class ChangeColumnRoomTypeToHotelRooms < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_rooms, :room_type, :string
    add_column :hotel_rooms, :room_type, :integer, default: 0
  end
end
