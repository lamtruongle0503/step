class ChangeColumnHotelPlan < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_plans, :hotel_option_id
    add_column :hotel_plans, :option_ids, :string, array: true, default: []
  end
end
