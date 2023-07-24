class CreateDeliveryTimeSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_time_settings do |t|
      t.belongs_to :product, foreign_key: true, index: true
      t.time :start_time
      t.time :end_time

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
