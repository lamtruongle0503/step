class CreateHotelOrderAccompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_order_accompanies do |t|
      t.boolean :is_owner, default: false
      t.string :full_name
      t.string :furigana
      t.integer :gender, default: 0
      t.string :postal_code
      t.string :phone_number
      t.string :telephone
      t.string :address1
      t.string :address2
      t.string :email

      t.timestamps
    end
  end
end
