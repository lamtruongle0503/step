class AddColumnToTourOrderAccompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_order_accompanies, :first_name, :string
    add_column :tour_order_accompanies, :last_name, :string
    add_column :tour_order_accompanies, :first_name_kana, :string
    add_column :tour_order_accompanies, :last_name_kana, :string
    remove_column :tour_order_accompanies, :age, :integer
    add_column :tour_order_accompanies, :birth_day, :date
    add_column :tour_order_accompanies, :post_code, :string
    add_column :tour_order_accompanies, :email, :string
    add_column :tour_order_accompanies, :address1, :string
    add_column :tour_order_accompanies, :address2, :string
    add_column :tour_order_accompanies, :depature_time, :string
    add_column :tour_order_accompanies, :departure_start_location, :string
  end
end
