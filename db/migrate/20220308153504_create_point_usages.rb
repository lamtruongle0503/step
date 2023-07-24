class CreatePointUsages < ActiveRecord::Migration[6.1]
  def change
    create_table :point_usages do |t|
      t.references :module, null: false, polymorphic: true
      t.integer :used_point

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
