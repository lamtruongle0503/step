class AddColumnOptionNameToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :option_name, :string
  end
end
