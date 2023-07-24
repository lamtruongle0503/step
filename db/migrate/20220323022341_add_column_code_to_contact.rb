class AddColumnCodeToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :code, :string
  end
end
