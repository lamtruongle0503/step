class ChnagTypeIntegerToBigint < ActiveRecord::Migration[6.1]
  def change
    change_column :hotel_plans, :rate_type, :bigint
    change_column :hotel_plans, :room_limit, :bigint
    change_column :hotel_plans, :settlement_date, :bigint
    change_column :hotel_plans, :point_receive, :bigint
    change_column :hotel_plans, :exp_point_receive, :bigint
    change_column :hotel_plans, :day_hidden, :bigint
    change_column :hotel_plans, :from_night, :bigint
    change_column :hotel_plans, :to_night, :bigint
    change_column :hotel_plans, :from_room, :bigint
    change_column :hotel_plans, :to_room, :bigint
  end
end
