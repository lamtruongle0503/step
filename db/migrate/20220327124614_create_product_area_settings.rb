class CreateProductAreaSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :product_area_settings do |t|
      t.belongs_to :product, foreign_key: true
      t.belongs_to :area_setting, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
