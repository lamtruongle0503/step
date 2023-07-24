class ChangeTableHotelPlans < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_plans, :setting_sale_off
    add_column :hotel_plans, :setting_sale_off, :string, array: true, default: []
  end
end
