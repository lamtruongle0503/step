class CreateHotelMeals < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_meals do |t|
      t.belongs_to :hotel, foriegn_key: true
      t.string :management_name
      t.string :name
      t.integer :type, default: 0
      t.boolean :is_used, default: false
      t.string :description
      t.string :address
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
