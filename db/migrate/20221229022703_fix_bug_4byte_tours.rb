class FixBug4byteTours < ActiveRecord::Migration[6.1]
  def change
    change_column :tour_informations, :adult_dayoff_discount, :bigint
    change_column :tour_informations, :adult_weekday_discount, :bigint
    change_column :tour_informations, :baby_dayoff_discount, :bigint
    change_column :tour_informations, :baby_weekday_discount, :bigint
    change_column :tour_informations, :children_dayoff_discount, :bigint
    change_column :tour_informations, :children_weekday_discount, :bigint

    change_column :tours, :min_number_participant, :bigint
    change_column :tours, :first_row_seat_price, :bigint
    change_column :tours, :regular_seat_price, :bigint
    change_column :tours, :exp_point_receive, :bigint
    change_column :tours, :exp_point_bonus, :bigint
  end
end
