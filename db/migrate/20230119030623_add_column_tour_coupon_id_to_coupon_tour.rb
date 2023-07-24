class AddColumnTourCouponIdToCouponTour < ActiveRecord::Migration[6.1]
  def change
    add_column :coupon_tours, :tour_coupon_id, :integer
  end
end
