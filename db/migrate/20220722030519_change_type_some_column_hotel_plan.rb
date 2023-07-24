class ChangeTypeSomeColumnHotelPlan < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_plans, :payments
    remove_column :hotel_plans, :setting_limit
    add_column :hotel_plans, :day_hidden, :integer
    add_column :hotel_plans, :setting_limit, :integer
    add_column :hotel_plans, :payments, :integer
    add_column :hotel_plans, :room_limit, :integer
    remove_column :hotel_plans, :setting_number_night_stay
    add_column :hotel_plans, :setting_number_night_stay, :integer
    add_column :hotel_plans, :from_night, :integer
    add_column :hotel_plans, :to_night, :integer
    remove_column :hotel_plans, :setting_limit_room
    add_column :hotel_plans, :setting_limit_room, :integer
    add_column :hotel_plans, :from_room, :integer
    add_column :hotel_plans, :to_room, :integer
    remove_column :hotel_plans, :setting_sale_off
    add_column :hotel_plans, :setting_sale_off, :jsonb
    add_column :hotel_plans, :is_sale_off, :integer
    remove_column :hotel_plans, :setting_check_in
    remove_column :hotel_plans, :setting_check_out
    add_column :hotel_plans, :setting_check_in_out, :integer
    add_column :hotel_plans, :check_in, :integer
    add_column :hotel_plans, :check_out, :integer
    remove_column :hotel_plans, :setting_children
    add_column :hotel_plans, :setting_children, :integer
    add_reference :hotel_plans, :hotel_option, foreign_key: true
  end
end
