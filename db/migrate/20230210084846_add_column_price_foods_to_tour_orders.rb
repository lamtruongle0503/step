class AddColumnPriceFoodsToTourOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_orders, :price_seat, :jsonb, default: {}
    add_column :tour_order_accompanies, :price_food, :jsonb, default: {}
  end
end
