class CreateDiaryCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :diary_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
