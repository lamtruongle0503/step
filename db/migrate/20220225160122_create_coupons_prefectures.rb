class CreateCouponsPrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons_prefectures do |t|
      t.belongs_to :coupon, foreign_key: true, index: true
      t.belongs_to :prefecture, foreign_key: true, index: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
