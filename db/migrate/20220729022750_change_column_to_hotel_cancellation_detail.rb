class ChangeColumnToHotelCancellationDetail < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_cancellation_details, :unit, :integer, default: 0
    add_column :hotel_cancellation_details, :unit, :integer, default: 1
  end
end
