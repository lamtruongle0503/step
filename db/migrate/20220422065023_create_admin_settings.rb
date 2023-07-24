class CreateAdminSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :admin_settings do |t|
      t.string :key
      t.string :value
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
