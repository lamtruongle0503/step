class ChangeColumnHotelCancellationDetail < ActiveRecord::Migration[6.1]
  def change
    add_reference :hotel_cancellation_policies, :hotel_cancellation_detail, index: { name: "index_hotel_policy_details" }
    add_column :hotel_cancellation_details, :name, :string
    rename_column :hotel_cancellation_details, :from, :flg1
    rename_column :hotel_cancellation_details, :to, :flg2
  end
end
