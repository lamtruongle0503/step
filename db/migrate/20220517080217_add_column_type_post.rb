class AddColumnTypePost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :type_post, :integer, default: 1
  end
end
