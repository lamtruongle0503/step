class AddColumnPurchasedIdHotelOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_orders, :purchased_id, :string
  end
end
