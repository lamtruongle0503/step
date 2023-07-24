class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :module, polymorphic: true, null: false
      t.string :title
      t.text :description
      t.boolean :send_all

      t.timestamps
    end
  end
end

