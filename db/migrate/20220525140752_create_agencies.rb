class CreateAgencies < ActiveRecord::Migration[6.1]
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :contact_address
      t.string :person
      t.boolean :is_free, default: false
      t.integer :fee_shipping

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
