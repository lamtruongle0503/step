class ChangeColumnToHotelRooms < ActiveRecord::Migration[6.1]
  def change
    change_column :hotel_rooms, :room_type, :string
    change_column_default :hotel_rooms, :room_type, nil
    remove_column :hotel_rooms, :is_smoking
    add_column :hotel_rooms, :is_smoking, :integer, default: 0
    add_column :hotel_rooms, :floor_type, :integer, default: 0
  end
end
