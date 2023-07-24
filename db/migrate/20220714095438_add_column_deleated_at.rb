class AddColumnDeleatedAt < ActiveRecord::Migration[6.1]
  def change
    add_column :hotels, :deleted_at, :datetime
  end
end
