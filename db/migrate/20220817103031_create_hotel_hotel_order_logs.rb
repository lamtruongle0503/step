class CreateHotelHotelOrderLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_order_logs do |t|
      t.belongs_to :hotel_order
      t.string :hotel_plan
      t.string :hotel_cancellation_patterns

      t.timestamps
    end
  end
end
