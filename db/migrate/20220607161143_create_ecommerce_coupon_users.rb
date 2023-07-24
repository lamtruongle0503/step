class CreateEcommerceCouponUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :ecommerce_coupon_users do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :coupon, foreign_key: true
      t.boolean :is_used, default: false

      t.timestamps
    end
  end
end
