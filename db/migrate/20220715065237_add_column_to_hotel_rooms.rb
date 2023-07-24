class AddColumnToHotelRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_rooms, :is_show, :boolean, default: false
  end
end
