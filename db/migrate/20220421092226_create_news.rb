class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :name
      t.datetime :published_at
      t.string :title
      t.string :url
      t.string :url_to_image
      t.string :author
      t.text :content
      t.text :description

      t.timestamps
    end
  end
end
