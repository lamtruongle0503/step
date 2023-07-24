class AddColumnDeliveryCodeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivery_code, :string
  end
end
