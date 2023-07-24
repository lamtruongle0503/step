class CreateAreaSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :area_settings do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
