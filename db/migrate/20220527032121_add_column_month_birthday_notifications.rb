class AddColumnMonthBirthdayNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :month_birthday, :text, null: true, array: true, default: []
  end
end
