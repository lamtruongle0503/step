class ChangeColumnCheckoutDateOrders < ActiveRecord::Migration[6.1]
  def change
    change_column :orders, :checkout_date, :date
  end
end
