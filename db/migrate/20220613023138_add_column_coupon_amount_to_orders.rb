class AddColumnCouponAmountToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :coupon_amount, :float
  end
end
