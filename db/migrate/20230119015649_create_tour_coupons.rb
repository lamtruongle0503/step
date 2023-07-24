class CreateTourCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_coupons do |t|
      t.string :code
      t.string :name
      t.date :start_time
      t.date :end_time
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
