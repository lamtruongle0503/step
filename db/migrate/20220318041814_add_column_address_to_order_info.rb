class AddColumnAddressToOrderInfo < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_infos, :address
    add_column :order_infos, :address1, :string
    add_column :order_infos, :address2, :string
  end
end
