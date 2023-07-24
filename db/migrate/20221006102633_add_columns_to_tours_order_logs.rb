class AddColumnsToToursOrderLogs < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_order_logs, :tour_hostels, :string
  end
end
