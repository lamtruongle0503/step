class CreateCouponsModules < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons_modules do |t|
      t.references :module, polymorphic: true, null: false
      t.references :coupon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
