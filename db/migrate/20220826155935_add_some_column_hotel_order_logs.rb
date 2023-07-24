class AddSomeColumnHotelOrderLogs < ActiveRecord::Migration[6.1]
  def change
    add_reference :hotel_order_logs, :hotel, foreign_key: true, index: true
    add_reference :hotel_order_logs, :hotel_room, foreign_key: true, index: true
    add_column :hotel_order_logs, :hotel_order_params, :jsonb
    remove_column :hotel_order_logs, :hotel_plan
    add_reference :hotel_order_logs, :hotel_plan, foreign_key: true, index: true
  end
end
