class CreateCouponUser < ActiveRecord::Migration[6.1]
  def change
    create_table :coupon_users do |t|
      t.belongs_to :coupon, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
