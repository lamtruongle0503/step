class CreateDeliverySettings < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_settings do |t|
      t.belongs_to :product, foreign_key: true, index: true
      t.string :vendor
      t.string :memo
      t.string :other

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
