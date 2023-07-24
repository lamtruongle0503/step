class CreateUserContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_contacts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address1
      t.string :address2
      t.date :birth_day
      t.string :code
      t.datetime :deleted_at
      t.boolean :diary_flg, default: false
      t.string :email
      t.datetime :expired_at
      t.string :first_name
      t.string :first_name_kana
      t.integer :gender, default: 0
      t.boolean :is_dm, default: true
      t.boolean :is_receive, default: true
      t.string :last_name
      t.string :last_name_kana
      t.string :name
      t.string :nick_name
      t.text :note
      t.string :password_digest
      t.string :phone_number
      t.float :point, default: 0.0
      t.string :post_code
      t.integer :status, default: 0
      t.string :telephone
      t.string :verify_code

      t.timestamps
    end
  end
end
