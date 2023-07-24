class CreateDistricts < ActiveRecord::Migration[6.1]
  def change
    create_table :districts do |t|
      t.string :name, unique: true
      t.belongs_to :prefecture, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
