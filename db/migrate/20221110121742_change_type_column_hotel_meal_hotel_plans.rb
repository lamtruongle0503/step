class ChangeTypeColumnHotelMealHotelPlans < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_plans, :type_meal
    add_column :hotel_plans, :type_meal, :string, array: true, default: []
  end
end
