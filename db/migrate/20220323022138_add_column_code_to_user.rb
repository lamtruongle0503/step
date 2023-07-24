class AddColumnCodeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :code, :string
  end
end
