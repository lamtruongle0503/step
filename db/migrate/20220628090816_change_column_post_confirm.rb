class ChangeColumnPostConfirm < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :is_confirm
    add_column :posts, :status, :integer, default: 0
  end
end
