class AddOptionColorNameToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :option_color_name, :string
  end
end
