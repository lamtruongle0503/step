class AddColumnToCoupon < ActiveRecord::Migration[6.1]
  def change
    add_column :coupon_tours, :type_coupon, :integer, :default => 0
  end
end
