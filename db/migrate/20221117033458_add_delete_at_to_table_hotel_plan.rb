class AddDeleteAtToTableHotelPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_cancellation_details, :deleted_at, :datetime
    add_column :hotel_cancellation_policies, :deleted_at, :datetime
    add_column :hotel_children_infos, :deleted_at, :datetime
    add_column :hotel_meals, :deleted_at, :datetime
    add_column :hotel_options, :deleted_at, :datetime
    add_column :hotel_orders, :deleted_at, :datetime
    add_column :hotel_order_accompanies, :deleted_at, :datetime
    add_column :hotel_order_logs, :deleted_at, :datetime
    add_column :hotel_plans, :deleted_at, :datetime
    add_column :hotel_plan_children, :deleted_at, :datetime
    add_column :hotel_plan_options, :deleted_at, :datetime
    add_column :hotel_requests, :deleted_at, :datetime
    add_column :hotel_rooms, :deleted_at, :datetime
    add_column :hotel_room_settings, :deleted_at, :datetime
  end
end
