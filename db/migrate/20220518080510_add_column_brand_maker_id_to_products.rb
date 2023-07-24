class AddColumnBrandMakerIdToProducts < ActiveRecord::Migration[6.1]
  def change
    add_reference :products, :brand_maker, index: true
  end
end
