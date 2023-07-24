class CreateBannerRequest < ActiveRecord::Migration[6.1]
  def change
    create_table :banner_requests do |t|
      t.belongs_to :banner, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.string :postal_code
      t.string :address1
      t.string :address2
      t.string :phone_number
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
