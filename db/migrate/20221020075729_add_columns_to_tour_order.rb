class AddColumnsToTourOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_orders, :is_seats_bus_free, :integer, :default => 0
  end
end
