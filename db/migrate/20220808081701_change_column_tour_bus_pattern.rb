class ChangeColumnTourBusPattern < ActiveRecord::Migration[6.1]
  def change
    remove_column :tour_bus_patterns, :map, :jsonb
    add_column :tour_bus_patterns, :map, :string
  end
end
