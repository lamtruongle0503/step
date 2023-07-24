class CreateTourOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_orders do |t|
      t.references :tour, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :tour_bus_info, null: false, foreign_key: true
      t.string :order_no
      t.date :departure_date
      t.string :departure_start_location
      t.integer :number_people
      t.string :room
      t.string :seat_selection
      t.string :payment_method
      t.integer :payment_status
      t.string :invoice_desc
      t.string :payment_note
      t.boolean :cancellation_free, default: false
      t.string :memo
      t.integer :discount_amount
      t.string :coupon
      t.integer :used_points
      t.integer :total

      t.timestamps
    end
  end
end
