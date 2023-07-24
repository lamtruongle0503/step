class AddComlumnsHotelRooms < ActiveRecord::Migration[6.1]
  def change
    remove_columns :hotel_rooms, :square_meters
    remove_columns :hotel_rooms, :total_floors
    add_column :hotel_rooms, :square_meter_max, :integer
    add_column :hotel_rooms, :square_meter_min, :integer
    add_column :hotel_rooms, :total_floor_max, :integer
    add_column :hotel_rooms, :total_floor_min, :integer
  end
end
