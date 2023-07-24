class AddColumnUsedPointToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :used_point, :float
  end
end
