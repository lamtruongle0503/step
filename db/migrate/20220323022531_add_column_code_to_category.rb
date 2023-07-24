class AddColumnCodeToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :code, :string
  end
end
