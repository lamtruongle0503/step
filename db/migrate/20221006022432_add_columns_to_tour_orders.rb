class AddColumnsToTourOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_orders, :price_refund, :float
    add_column :tour_orders, :refund_comfirm_date, :datetime
  end
end
