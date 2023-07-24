class AddColumnPriceToDeliverySetting < ActiveRecord::Migration[6.1]
  def change
    add_column :delivery_settings, :price, :float
    add_column :delivery_settings, :is_free, :boolean, default: true
  end
end
