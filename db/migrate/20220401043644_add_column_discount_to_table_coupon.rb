class AddColumnDiscountToTableCoupon < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons, :discount, :float
  end
end
