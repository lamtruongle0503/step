class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :note, :text
    add_column :users, :is_dm, :boolean
  end
end
