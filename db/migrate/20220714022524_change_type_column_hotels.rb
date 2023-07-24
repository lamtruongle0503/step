class ChangeTypeColumnHotels < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotels, :allow_children
    remove_column :hotels, :alow_pet
    add_column :hotels, :allow_children, :integer
    add_column :hotels, :allow_pet, :integer
  end
end
