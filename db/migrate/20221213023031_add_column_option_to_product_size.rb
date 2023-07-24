class AddColumnOptionToProductSize < ActiveRecord::Migration[6.1]
  def change
    add_column :product_sizes, :is_product_size, :boolean, default: true
    add_column :product_sizes, :option_size_name, :string
    add_column :product_sizes, :is_color_name, :boolean, default: true
    add_column :product_sizes, :option_color_name, :string
    add_column :product_sizes, :color_name, :string
  end
end
