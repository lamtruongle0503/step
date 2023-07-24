class RenameColumnAssetsModule < ActiveRecord::Migration[6.1]
  def change
    rename_column :assets_modules, :assets_id, :asset_id
    rename_column :assets, :data, :file_data
  end
end
