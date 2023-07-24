class AddColumnToToursOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_orders, :purchased_id, :string
  end
end
