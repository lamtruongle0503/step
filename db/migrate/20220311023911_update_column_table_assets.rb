class UpdateColumnTableAssets < ActiveRecord::Migration[6.1]
  def change
    remove_column :assets,:file
    remove_column :assets,:name
    remove_column :assets,:file_data
    add_column :assets, :url, :string
  end
end
