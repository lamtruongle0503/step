class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :full_name
      t.string :postcode
      t.string :address1
      t.string :address2
      t.string :telephone
      t.datetime :deleted_at
      t.boolean :is_default, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
