class ChangeColumnToTourOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_orders, :total_tour, :float
    add_column :tour_orders, :total_tour_bus_seat_map, :float
    add_column :tour_orders, :total_tour_option, :float
    remove_column :tour_orders, :payment_method, :string
    add_column :tour_orders, :payment_method, :integer, default: 0
    add_column :tour_orders, :cancellation_fee, :float
    add_column :tour_orders, :date_of_cancellation, :date
    remove_column :tour_orders, :room, :string
    add_column :tour_orders, :room, :jsonb, default: {}
    add_column :tour_orders, :total_price_special_food, :float
    add_reference :tour_orders , :tour_stay_departure
    add_column :tour_orders, :received_bonus_point, :integer
    add_column :tour_orders, :received_point, :integer
    remove_column :tour_orders, :coupon, :string
    add_column :tour_orders, :coupon_id, :integer
    add_column :tour_orders, :coupon_discount, :float
    add_column :tour_orders, :total_price_stay_departure, :float
  end
end
