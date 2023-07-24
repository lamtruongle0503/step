class CreateTableLife < ActiveRecord::Migration[6.1]
  def change
    create_table :life_supports do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.text :content
      t.string :telephone
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
