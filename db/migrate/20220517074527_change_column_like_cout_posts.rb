class ChangeColumnLikeCoutPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :like_count, :integer, default: 0
  end
end
