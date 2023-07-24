class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.belongs_to :category, foreign_key: true, index: true
      t.string :code
      t.string :name
      t.text :description
      t.float :discount
      t.boolean :is_discount, default: false
      t.string :colors
      t.integer :remaining_count, default: 0
      t.text :description_info
      t.string :brand
      t.string :original_country
      t.string :distributor
      t.string :precaution
      t.integer :desired_deliver_date
      t.string :hash_tag
      t.boolean :is_show, default: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
