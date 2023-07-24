class ChangeColumnBrandMakerProducts < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :brand_maker_id
    add_reference :products, :agency, index: true
  end
end
