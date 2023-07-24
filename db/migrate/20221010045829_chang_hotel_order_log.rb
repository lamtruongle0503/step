class ChangHotelOrderLog < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_order_logs, :hotel_cancellation_patterns
    remove_foreign_key :hotel_order_logs, column: :hotel_id
    remove_foreign_key :hotel_order_logs, column: :hotel_plan_id
    remove_foreign_key :hotel_order_logs, column: :hotel_room_id

    add_column :hotel_order_logs, :plan, :jsonb
    add_column :hotel_order_logs, :hotel, :jsonb
    add_column :hotel_order_logs, :room, :jsonb
    add_column :hotel_order_logs, :hotel_order_info, :jsonb
  end
end
