class ChangeTypePaymentHotelPlans < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_plans, :payments
    add_column :hotel_plans, :payments, :string, array: true, default: []
  end
end
