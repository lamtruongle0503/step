class AddCodeToTableDistrict < ActiveRecord::Migration[6.1]
  def change
    add_column :districts, :code, :string
  end
end
