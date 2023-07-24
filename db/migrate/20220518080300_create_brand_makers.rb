class CreateBrandMakers < ActiveRecord::Migration[6.1]
  def change
    create_table :brand_makers do |t|
      t.string :name
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
