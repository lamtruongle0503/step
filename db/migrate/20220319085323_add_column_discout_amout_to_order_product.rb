class AddColumnDiscoutAmoutToOrderProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :order_products, :discount, :float, default: 100
    add_column :order_products, :color, :string
    add_column :order_products, :product_size_id, :integer
  end
end
