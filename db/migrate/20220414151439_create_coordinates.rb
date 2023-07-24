class CreateCoordinates < ActiveRecord::Migration[6.1]
  def change
    create_table :coordinates do |t|
      t.references :module, polymorphic: true
      t.float :latitude
      t.float :longitude
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
