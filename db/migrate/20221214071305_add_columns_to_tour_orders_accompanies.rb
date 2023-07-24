class AddColumnsToTourOrdersAccompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_order_accompanies, :is_user, :boolean, default: false
    add_column :tour_orders, :estimate_payment_amount, :float
    add_column :tour_orders, :estimate_payment_confirmation_date, :date
    add_column :tour_orders, :payment_confirmation_date, :date
  end
end
