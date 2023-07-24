class ChangeColumnToTourOrderLogs < ActiveRecord::Migration[6.1]
  def change
    remove_column :tour_order_logs, :tour, :string
    remove_column :tour_order_logs, :tour_cancellation_patterns, :string
    remove_column :tour_order_logs, :tour_information, :string
    remove_column :tour_order_logs, :tour_stay_departures, :string
    add_column :tour_order_logs, :tour, :jsonb, default: {}
    add_column :tour_order_logs, :tour_cancellation_patterns, :jsonb, default: {}
    add_column :tour_order_logs, :tour_information, :jsonb, default: {}
    add_column :tour_order_logs, :tour_stay_departures, :jsonb, default: {}
  end
end
