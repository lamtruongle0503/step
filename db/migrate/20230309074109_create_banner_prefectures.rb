class CreateBannerPrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :banner_prefectures do |t|
      t.belongs_to :banner, foreign_key: true
      t.belongs_to :prefecture, foreign_key: true

      t.timestamps
    end
  end
end
