class CreateTourHotels < ActiveRecord::Migration[6.1]
  def change
    create_table :hotels do |t|
      t.string :name, null: false
      t.string :yomigana
      t.string :postal_code
      t.string :telephone
      t.float :web_comm_fee
      t.string :address1
      t.string :address2
      t.string :manager
      t.string :contact_info
      t.string :representative
      t.integer :status, default: 0
      t.integer :prefecture_id
      t.integer :area_setting_id
      t.integer :hotel_category_id
      t.string :fax_number
      t.date :opening_date
      t.date :refurbished_date
      t.integer :room_total
      t.string :manager_info
      t.float :reservation_comm_fee
      t.float :purchased_fee
      t.float :credit_settlement_fee
      t.string :pr_desc
      t.string :access_desc
      t.string :parking_desc
      t.jsonb :feature_options
      t.jsonb :amenity_options
      t.integer :tax_service_id
      t.string :tax_information
      t.string :allow_children
      t.string :children_information
      t.boolean :alow_pet, default: false
      t.string :pet_information
      t.string :other_information

      t.timestamps
    end
  end
end
