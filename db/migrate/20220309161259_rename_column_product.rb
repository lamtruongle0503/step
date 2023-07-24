class RenameColumnProduct < ActiveRecord::Migration[6.1]
  def change
    rename_column :products, :desired_deliver_date, :desired_delivery_date
  end
end
