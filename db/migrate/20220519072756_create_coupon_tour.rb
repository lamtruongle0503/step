class CreateCouponTour < ActiveRecord::Migration[6.1]
  def change
    create_table :coupon_tours do |t|
      t.date :start_time
      t.date :end_time
      t.date :publish_date
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
