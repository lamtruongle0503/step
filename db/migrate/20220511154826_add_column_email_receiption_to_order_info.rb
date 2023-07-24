class AddColumnEmailReceiptionToOrderInfo < ActiveRecord::Migration[6.1]
  def change
    add_column :order_infos, :email_receiption, :string
  end
end
