class AddColumnForeignKeyHotelCancellation < ActiveRecord::Migration[6.1]
  def change
    add_reference :hotels, :hotel_cancellation_policy
  end
end
