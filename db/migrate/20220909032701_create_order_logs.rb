class CreateOrderLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :order_logs do |t|
      t.jsonb     :product, default: {}
      t.jsonb     :product_size, default: {}
      t.references :order_products, null: false, foreign_key: true

      t.timestamps
    end
  end
end
