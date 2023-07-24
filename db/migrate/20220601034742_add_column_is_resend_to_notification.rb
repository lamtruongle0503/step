class AddColumnIsResendToNotification < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :is_resend, :boolean, default: false
  end
end
