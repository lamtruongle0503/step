class CreateProductSizes < ActiveRecord::Migration[6.1]
  def change
    create_table :product_sizes do |t|
      t.belongs_to :product, foreign_key: true, index: true
      t.string :name
      t.float :price

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
