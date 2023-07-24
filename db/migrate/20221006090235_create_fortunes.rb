class CreateFortunes < ActiveRecord::Migration[6.1]
  def change
    create_table :fortunes do |t|
      t.string :fortune_type
      t.string :title
      t.string :sign
      t.string :param
      t.string :image
      t.text :text
      t.integer :rank
      t.string :color
      t.string :item


      t.timestamps
    end
  end
end
