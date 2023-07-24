class AddColumnBuyNameTableOrderInfo < ActiveRecord::Migration[6.1]
  def change
    add_column :order_infos, :buy_name, :string
  end
end
