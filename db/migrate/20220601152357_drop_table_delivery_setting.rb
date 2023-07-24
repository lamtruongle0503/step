class DropTableDeliverySetting < ActiveRecord::Migration[6.1]
  def change
    drop_table :delivery_settings do |t|
      t.belongs_to :product, foreign_key: true, index: true
      t.string :vendor
      t.string :memo
      t.string :other
      t.float :price
      t.boolean :is_free, default: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
