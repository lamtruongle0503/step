class CreateContactCategory < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_categories do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
