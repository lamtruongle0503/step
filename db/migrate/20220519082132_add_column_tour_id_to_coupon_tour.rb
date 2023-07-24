class AddColumnTourIdToCouponTour < ActiveRecord::Migration[6.1]
  def change
    add_reference :coupon_tours, :tour
  end
end
