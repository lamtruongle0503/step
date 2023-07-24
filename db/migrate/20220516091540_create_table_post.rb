class CreateTablePost < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :contents
      t.references :user, null: false, foreign_key: true
      t.integer :like_count
      t.references :diary_category, null: false, foreign_key: true
      t.integer :type
      t.string :background_color
      t.boolean :is_confirm

      t.timestamps
    end
  end
end
