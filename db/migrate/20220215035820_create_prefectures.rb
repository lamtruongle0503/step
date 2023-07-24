class CreatePrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :prefectures do |t|
      t.string :name
      t.string :prefecture_jis_code
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
