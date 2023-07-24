class CreateAssetsModules < ActiveRecord::Migration[6.1]
  def change
    create_table :assets_modules do |t|
      t.references :module, null: false, polymorphic: true
      t.belongs_to :assets, foreign_key: true, null: false

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
