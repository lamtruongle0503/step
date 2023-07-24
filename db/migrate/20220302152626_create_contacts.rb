class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.belongs_to :user, foreign_key: true
      t.text :contents
      t.string :phone_number
      t.string :email
      t.integer :status, default: 1

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
