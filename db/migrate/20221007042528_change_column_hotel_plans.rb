class ChangeColumnHotelPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_plans, :settlement_date, :integer
    add_column :hotel_plans, :settlement_time, :string
  end
end
