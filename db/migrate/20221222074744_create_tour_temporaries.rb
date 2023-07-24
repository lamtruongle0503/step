class CreateTourTemporaries < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_temporaries do |t|
      t.references :tour
      t.references :tour_order_special
      t.string :name
      t.string :furigana
      t.string :postal_code
      t.string :address1
      t.string :address2
      t.string :telephone
      t.string :phone_number
      t.integer :age
      t.integer :gender

      t.timestamps
    end
  end
end
