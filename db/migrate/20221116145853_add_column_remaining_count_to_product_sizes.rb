class AddColumnRemainingCountToProductSizes < ActiveRecord::Migration[6.1]
  def change
    add_column :product_sizes, :remaining_count, :integer
    add_column :product_sizes, :is_limit, :boolean, default: false
  end
end
