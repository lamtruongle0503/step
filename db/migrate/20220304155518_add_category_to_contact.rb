class AddCategoryToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :contact_category_id, :integer, foreign_key: true
  end
end
