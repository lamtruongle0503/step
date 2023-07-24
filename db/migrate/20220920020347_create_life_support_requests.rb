class CreateLifeSupportRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :life_support_requests do |t|
      t.belongs_to :life_support, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.string :postal_code
      t.string :address1
      t.string :address2
      t.string :phone_number
      t.timestamps
    end
  end
end
