class AddColumnsToToursOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_orders, :concentrate_time, :string
    add_column :tour_orders, :depature_time, :string
  end
end
