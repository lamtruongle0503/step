class UpdateColumnTableOrderAndOrderProducts < ActiveRecord::Migration[6.1]
  def change
    rename_column :order_products, :purchased_amout, :purchased_amount
    rename_column :orders, :purchased_amout, :purchased_amount
    rename_column :orders, :delivery_amout, :delivery_amount
  end

end
