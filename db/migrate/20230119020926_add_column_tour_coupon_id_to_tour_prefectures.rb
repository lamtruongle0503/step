class AddColumnTourCouponIdToTourPrefectures < ActiveRecord::Migration[6.1]
  def change
    add_column :tours_prefectures, :tour_coupon_id, :integer
  end
end
