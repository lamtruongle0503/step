class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :publish_date

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
