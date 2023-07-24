class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.string :module_name
      t.string :action
      t.string :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
