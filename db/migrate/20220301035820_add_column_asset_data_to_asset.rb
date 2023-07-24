class AddColumnAssetDataToAsset < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :data, :jsonb
  end
end
