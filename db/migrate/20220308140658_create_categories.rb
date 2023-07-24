class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :ranking
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
