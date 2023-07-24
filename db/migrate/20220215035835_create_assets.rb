class CreateAssets < ActiveRecord::Migration[6.1]
  def change
    create_table :assets do |t|
      t.string :file
      t.string :name
      t.string :type

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
