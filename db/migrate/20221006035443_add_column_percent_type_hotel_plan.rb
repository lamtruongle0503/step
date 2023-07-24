class AddColumnPercentTypeHotelPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_plans, :rate_type, :integer
  end
end
