class CreateUsersNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :users_notifications do |t|
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :notification, foreign_key: true, index: true
      t.boolean :is_read, index: true, default: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
