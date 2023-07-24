class CreateLifeSupportPrefectures < ActiveRecord::Migration[6.1]
  def change
    create_table :life_support_prefectures do |t|
      t.belongs_to :life_support, foreign_key: true
      t.belongs_to :prefecture, foreign_key: true

      t.timestamps
    end
  end
end
