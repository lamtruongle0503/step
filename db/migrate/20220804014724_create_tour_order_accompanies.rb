class CreateTourOrderAccompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_order_accompanies do |t|
      t.boolean :is_owner, default: false
      t.string :full_name
      t.string :furigana
      t.integer :gender, default: 0
      t.integer :age
      t.string :phone_number
      t.string :telephone
      t.string :room
      t.string :selected_seat
      t.integer :pickup_location
      t.boolean :is_save, default: false
      t.references :tour_order, null: false, foreign_key: true
      t.references :tour_special_food, null: false, foreign_key: true
      t.references :tour_option, null: false, foreign_key: true

      t.timestamps
    end
  end
end
