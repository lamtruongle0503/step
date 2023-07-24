class ChangeColumnTypeToComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :type
    add_column :comments, :comment_type, :string
  end
end
