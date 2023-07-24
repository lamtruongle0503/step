class AddColoumnToTourOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :tour_orders, :total, :integer
    add_column :tour_orders, :total, :float, default: 0
    add_column :tour_orders, :initial_price, :float, default: 0
  end
end
