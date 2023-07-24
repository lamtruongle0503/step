class AddColumnCouponTourIdToCoupon < ActiveRecord::Migration[6.1]
  def change
    add_reference :coupons, :coupon_tour
  end
end
