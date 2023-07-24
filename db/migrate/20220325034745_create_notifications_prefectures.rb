class CreateNotificationsPrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications_prefectures do |t|
      t.references :prefecture, null: false, foreign_key: true
      t.references :notification, null: false, foreign_key: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
