class AddColumnCouponToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :coupon_id, :integer
  end
end
