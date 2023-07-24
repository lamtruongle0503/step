class AddUserContactToHotelOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :hotel_orders, :user_contact
  end
end
