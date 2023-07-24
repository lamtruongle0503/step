class AddDefaultColumnPost < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :is_confirm, :boolean, default: false
    remove_column :posts, :type
  end
end
