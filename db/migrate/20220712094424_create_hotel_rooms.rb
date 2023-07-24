class CreateHotelRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_rooms do |t|
      t.belongs_to :hotel, foreign_key: true
      t.string :name
      t.date :setting_date
      t.string :management_name
      t.integer :room_type, default: 0
      t.integer :floor_number
      t.boolean :is_smoking, default: false
      t.string :description
      t.integer :capacity
      t.integer :square_meters
      t.string :floor_plan
      t.integer :total_floors

      t.timestamps
    end
  end
end
