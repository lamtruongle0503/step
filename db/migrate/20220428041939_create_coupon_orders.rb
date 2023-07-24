class CreateCouponOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :coupon_orders do |t|
      t.references :coupon, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
