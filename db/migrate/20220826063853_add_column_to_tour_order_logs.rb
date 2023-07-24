class AddColumnToTourOrderLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_order_logs, :tour_options, :string, array: true, default: []
    add_column :tour_order_logs, :price_tour_information, :jsonb, default: {}
    add_column :tour_order_logs, :price_special_food, :jsonb, default: {}
  end
end
