class AddColumnHotelOrderNumberRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_orders, :total_room, :integer, default: 1
  end
end
