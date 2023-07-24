class AddColumnIsDeliveryFreeToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :is_delivery_free, :boolean, default: false
  end
end
