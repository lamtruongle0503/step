class ChangeColumnHotelOrderPaymentMethod < ActiveRecord::Migration[6.1]
  def change
    change_column :hotel_orders, :payment_method, 'integer USING CAST(payment_method AS integer)'
    change_column :hotel_orders, :status, :integer, default: 0
    add_column :hotel_orders, :payment_status, :integer
    add_column :hotel_orders, :payment_note, :string
  end
end
