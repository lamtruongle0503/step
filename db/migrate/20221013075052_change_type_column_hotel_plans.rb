class ChangeTypeColumnHotelPlans < ActiveRecord::Migration[6.1]
  def change
    change_column :hotel_plans, :check_in, :string
    change_column :hotel_plans, :check_out, :string
  end
end
