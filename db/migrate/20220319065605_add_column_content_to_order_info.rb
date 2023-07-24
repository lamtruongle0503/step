class AddColumnContentToOrderInfo < ActiveRecord::Migration[6.1]
  def change
    add_column :order_infos, :content, :string
  end
end
