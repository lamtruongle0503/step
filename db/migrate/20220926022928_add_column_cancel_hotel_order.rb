class AddColumnCancelHotelOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_orders, :date_cancel, :date
  end
end
