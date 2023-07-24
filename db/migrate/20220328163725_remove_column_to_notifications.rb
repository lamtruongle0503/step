class RemoveColumnToNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :module_type
    remove_column :notifications, :module_id
    add_reference :notifications, :module, polymorphic: true, null: true
  end
end
