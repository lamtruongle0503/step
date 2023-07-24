class AddColumnDeletedAtToNews < ActiveRecord::Migration[6.1]
  def change
    add_column :news, :deleted_at, :datetime
  end
end
