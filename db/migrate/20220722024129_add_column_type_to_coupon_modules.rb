class AddColumnTypeToCouponModules < ActiveRecord::Migration[6.1]
  def change
    add_column :coupons_modules, :type, :string
  end
end
