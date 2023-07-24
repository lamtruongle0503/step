class AddSomeColumnHotelOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_order_accompanies, :full_name
    remove_column :hotel_order_accompanies, :furigana
    add_column :hotel_order_accompanies, :birth_day, :date
    add_column :hotel_order_accompanies, :first_name, :string
    add_column :hotel_order_accompanies, :last_name, :string
    add_column :hotel_order_accompanies, :first_name_kana, :string
    add_column :hotel_order_accompanies, :last_name_kana, :string
    add_column :hotel_orders, :number_night, :integer
    add_column :hotel_orders, :adult_total, :integer
    add_column :hotel_orders, :person_total, :integer
    add_column :hotel_orders, :childrens, :jsonb
    add_column :hotel_orders, :price_room, :integer, default: 0
    add_column :hotel_orders, :price_option, :integer, default: 0
    add_column :hotel_orders, :price_sale_off_stay_night, :integer, default: 0
    add_column :hotel_orders, :price_children, :integer, default: 0
    add_column :hotel_orders, :time_estimate, :string
    add_column :hotel_orders, :comments, :string
  end
end
