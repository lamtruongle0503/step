class CreateOrderProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :order_products do |t|
      t.belongs_to :order, foreign_key: true, index: true
      t.belongs_to :product, foreign_key: true, index: true
      t.float :price
      t.integer :number
      t.float :purchased_amout

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
