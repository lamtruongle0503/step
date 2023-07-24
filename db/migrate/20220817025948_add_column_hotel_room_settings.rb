class AddColumnHotelRoomSettings < ActiveRecord::Migration[6.1]
  def change
    change_column :hotel_room_settings, :one_person_fee, :integer, default: 0
    change_column :hotel_room_settings, :two_people_fee, :integer, default: 0
    change_column :hotel_room_settings, :three_people_fee, :integer, default: 0
    change_column :hotel_room_settings, :four_people_fee, :integer, default: 0
    change_column :hotel_room_settings, :five_people_fee, :integer, default: 0
    add_column :hotel_room_settings, :six_person_fee, :integer, default: 0
    add_column :hotel_room_settings, :seven_person_fee, :integer, default: 0
    add_column :hotel_room_settings, :eight_person_fee, :integer, default: 0
    add_column :hotel_room_settings, :nine_person_fee, :integer, default: 0
    add_column :hotel_room_settings, :ten_person_fee, :integer, default: 0
  end
end
