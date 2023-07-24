class ChangeColumnOrderLogs < ActiveRecord::Migration[6.1]
  def change
    remove_column :tour_order_logs, :tour_options, :string
    add_column :tour_order_logs, :tour_options, :string
  end
end
