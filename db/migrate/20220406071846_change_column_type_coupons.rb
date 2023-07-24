class ChangeColumnTypeCoupons < ActiveRecord::Migration[6.1]
  def change
    change_column :coupons, :start_time, :date
    change_column :coupons, :end_time, :date
    change_column :coupons, :publish_date, :date
  end
end
