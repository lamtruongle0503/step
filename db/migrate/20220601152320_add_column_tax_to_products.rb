class AddColumnTaxToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :tax, :integer
    add_column :products, :is_product_size, :boolean, default: true
    add_column :products, :shipping_memo, :text
    add_column :products, :shipping_others, :text
  end
end
