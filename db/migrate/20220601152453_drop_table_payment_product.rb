class DropTablePaymentProduct < ActiveRecord::Migration[6.1]
  def change
    drop_table :payments_products do |t|
      t.integer :payment_id
      t.integer :product_id
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
