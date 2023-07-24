class ChangeColumnCommentToComments < ActiveRecord::Migration[6.1]
  def change
    change_column :comments, :comment_id, :integer, null: true
  end
end
