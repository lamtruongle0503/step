class AddColumnToTourOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_orders, :status, :integer, default: 0
  end
end
