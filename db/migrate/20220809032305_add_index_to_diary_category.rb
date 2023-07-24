class AddIndexToDiaryCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :diary_categories, :index, :integer
  end
end
