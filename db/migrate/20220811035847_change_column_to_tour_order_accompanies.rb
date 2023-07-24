class ChangeColumnToTourOrderAccompanies < ActiveRecord::Migration[6.1]
  def change
    remove_column :tour_order_accompanies , :tour_special_food_id
    remove_column :tour_order_accompanies , :tour_option_id
    add_reference :tour_order_accompanies , :tour_special_food
    add_reference :tour_order_accompanies , :tour_option
  end
end
