class CreateCouponTourPrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :coupon_tour_prefectures do |t|
      t.belongs_to :coupon_tour, foreign_key: true
      t.belongs_to :prefecture, foreign_key: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
