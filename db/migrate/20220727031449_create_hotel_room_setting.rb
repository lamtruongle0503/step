class CreateHotelRoomSetting < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_room_settings do |t|
      t.references :hotel_plan, null: false, foreign_key: true
      t.references :hotel_room, null: false, foreign_key: true
      t.date :date
      t.integer :remain_room
      t.integer :reservation_number
      t.integer :one_person_fee
      t.integer :two_people_fee
      t.integer :three_people_fee
      t.integer :four_people_fee
      t.integer :five_people_fee

      t.timestamps
    end
  end
end
