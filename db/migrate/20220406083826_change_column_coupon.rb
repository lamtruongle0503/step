class ChangeColumnCoupon < ActiveRecord::Migration[6.1]
  def change
    rename_column :coupons, :discount, :price
  end
end
