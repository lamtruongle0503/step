class ChangeTypeSomeColumnTableRoomSetting < ActiveRecord::Migration[6.1]
  def change
    change_column :hotel_room_settings, :one_person_fee, :bigint
    change_column :hotel_room_settings, :two_people_fee, :bigint
    change_column :hotel_room_settings, :three_people_fee, :bigint
    change_column :hotel_room_settings, :four_people_fee, :bigint
    change_column :hotel_room_settings, :five_people_fee, :bigint
    change_column :hotel_room_settings, :six_person_fee, :bigint
    change_column :hotel_room_settings, :seven_person_fee, :bigint
    change_column :hotel_room_settings, :eight_person_fee, :bigint
    change_column :hotel_room_settings, :nine_person_fee, :bigint
    change_column :hotel_room_settings, :ten_person_fee, :bigint
  end
end
