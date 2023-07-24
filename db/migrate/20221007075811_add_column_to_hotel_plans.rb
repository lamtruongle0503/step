class AddColumnToHotelPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_plans, :credit_card_transaction_fee, :integer
  end
end
