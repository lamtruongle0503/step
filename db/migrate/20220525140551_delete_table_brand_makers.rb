class DeleteTableBrandMakers < ActiveRecord::Migration[6.1]
  def change
    drop_table :brand_makers
  end
end
