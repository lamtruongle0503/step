class AddColumnPointReceivedToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :received_point, :float
  end
end
