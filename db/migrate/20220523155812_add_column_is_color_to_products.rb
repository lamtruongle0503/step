class AddColumnIsColorToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :is_color, :boolean, default: false
  end
end
