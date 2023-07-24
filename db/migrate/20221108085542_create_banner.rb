class CreateBanner < ActiveRecord::Migration[6.1]
  def change
    create_table :banners do |t|
      t.string :name
      t.boolean :is_show

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
