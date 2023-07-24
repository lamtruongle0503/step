class AddColumnDeliveryTypeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivery_id, :integer
    remove_column :orders, :payment_type, :integer
    add_column :orders, :payment_id, :integer
  end
end
