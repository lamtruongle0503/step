class AddFileTypeToAssets < ActiveRecord::Migration[6.1]
  def change
    add_column :assets, :file_type, :string
  end
end
