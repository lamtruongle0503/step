class AddColumnForeginToTours < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :destination, :string
    add_column :tours, :discount, :integer
    add_column :tours, :end_date, :datetime
    add_column :tours, :exp_point_bonus, :integer
    add_column :tours, :exp_point_receive, :integer
    add_column :tours, :first_row_seat_price, :float
    add_column :tours, :hostel_list, :integer
    add_column :tours, :is_show_guide, :boolean, default: false
    add_column :tours, :meal_description, :string
    add_column :tours, :point_bonus_rate, :integer
    add_column :tours, :point_receive_rate, :integer
    add_column :tours, :regular_seat_price, :float
    add_column :tours, :start_date, :datetime
    add_column :tours, :status, :integer, default: 0
    add_column :tours, :stayed_nights, :integer
    add_column :tours, :tax, :integer
    add_column :tours, :title, :string
    add_column :tours, :tour_guide, :string
    add_column :tours, :two_rows_seat_price, :float
    add_column :tours, :type_locate, :integer, default: 0
    add_reference :tours, :company_staff, foreign_key: true
    add_reference :tours, :tour_category, foreign_key: true
  end
end
