class CreateHotelOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_orders do |t|
      t.string :order_no
      t.belongs_to :hotel, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.belongs_to :hotel_plan, foreign_key: true
      t.belongs_to :hotel_order_accompany, foreign_key: true
      t.integer :status
      t.string :rooms, default: [], array: true
      t.string :check_in
      t.string :check_out
      t.belongs_to :coupon, foreign_key: true
      t.integer :cancellation_type
      t.string :cancellation_other_reason
      t.boolean :cancellation_free
      t.integer :people_per_room
      t.integer :number_of_rooms
      t.integer :total_peoples
      t.string :people_statistic
      t.integer :used_points
      t.integer :discount_amount
      t.integer :reservation_amount
      t.integer :tax_service
      t.integer :total
      t.string :payment_method
      t.string :registration_pattern
      t.string :registrar_name
      t.string :phone_reciprocal_time
      t.string :manifest
      t.string :option_ids, default: [], array: true

      t.timestamps
    end
  end
end
