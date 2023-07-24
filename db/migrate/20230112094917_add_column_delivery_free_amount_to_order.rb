class AddColumnDeliveryFreeAmountToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivery_free_amount, :integer
  end
end
