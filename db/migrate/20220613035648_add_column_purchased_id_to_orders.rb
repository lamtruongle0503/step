class AddColumnPurchasedIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :purchased_id, :string
  end
end
