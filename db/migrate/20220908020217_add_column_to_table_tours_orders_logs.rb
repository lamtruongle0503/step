class AddColumnToTableToursOrdersLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_order_logs, :amount_tour_bus_seat_map, :jsonb, default: {}
  end
end
