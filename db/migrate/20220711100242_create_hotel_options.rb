class CreateHotelOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_options do |t|
      t.belongs_to :hotel, foreign_key: true
      t.string :management_name
      t.string :name
      t.float :price
      t.integer :unit, default: 0
      t.boolean :is_use, default: false
      t.string :description

      t.timestamps
    end
  end
end
