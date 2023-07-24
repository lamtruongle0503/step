class AddColumnDeliveryChargesFeeToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivery_charges_fee, :float
  end
end
