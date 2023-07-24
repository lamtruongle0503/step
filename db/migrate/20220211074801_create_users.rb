class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :phone_number
      t.string :first_name
      t.string :last_name
      t.string :first_name_kana
      t.string :last_name_kana
      t.integer :gender
      t.date :birth_day
      t.string :post_code
      t.string :address1
      t.string :address2
      t.string :verify_code
      t.datetime :expired_at

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
