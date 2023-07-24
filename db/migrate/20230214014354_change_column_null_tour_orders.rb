class ChangeColumnNullTourOrders < ActiveRecord::Migration[6.1]
  def change
    change_column_null :tour_orders, :user_id, true
  end
end
