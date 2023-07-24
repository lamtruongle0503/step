class AddColumnStatusHotelRoomSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_room_settings, :status, :integer, default: 0
  end
end
