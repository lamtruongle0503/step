class CreateHotelRequest < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_requests do |t|
      t.belongs_to :hotel, foreign_key: true
      t.belongs_to :hotel_plan, foreign_key: true
      t.belongs_to :hotel_room, foreign_key: true
      t.string :full_name
      t.string :phone_number
      t.string :email
      t.date :check_in
      t.date :check_out
      t.integer :total_person
      t.integer :total_room
      t.integer :room_type
      t.string :comments

      t.timestamps
    end
  end
end
