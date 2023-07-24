class AddColumnCancellationFeeHotelOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_orders, :cancellation_fee, :integer
  end
end
