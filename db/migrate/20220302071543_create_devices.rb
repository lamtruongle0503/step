class CreateDevices < ActiveRecord::Migration[6.1]
  def change
    create_table :devices do |t|
      t.belongs_to :user, foreign_key: true
      t.string :os
      t.string :device_token
      t.datetime :deleted_at
      t.boolean :is_receive

      t.timestamps
    end
  end
end
