class ChangeColumnPost < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :diary_category_id, :integer, null: true
  end
end
