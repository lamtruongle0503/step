class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :contents
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
