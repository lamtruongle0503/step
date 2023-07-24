class ChangeColumnTableOrderInfo < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_infos, :buyer_name
    remove_column :order_infos, :postal_code
    remove_column :order_infos, :prefecture
    remove_column :order_infos, :address1
    remove_column :order_infos, :address2
    add_reference :order_infos, :address, index: true
  end
end
