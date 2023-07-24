class AddSomeColumnToTableNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :gender, :integer
    add_column :notifications, :is_gender, :boolean, default: false
    add_column :notifications, :is_prefecture, :boolean, default: false
  end
end
