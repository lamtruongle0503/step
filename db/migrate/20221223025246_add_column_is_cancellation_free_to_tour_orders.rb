class AddColumnIsCancellationFreeToTourOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_orders, :is_cancellation_free, :boolean, default: false
  end
end
