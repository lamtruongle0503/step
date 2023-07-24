class AddColumnDeliveryChargesToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :delivery_charges_fee, :float
    add_column :products, :is_delivery_charges, :boolean, default: false
  end
end
