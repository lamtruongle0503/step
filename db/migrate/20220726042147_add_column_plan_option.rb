class AddColumnPlanOption < ActiveRecord::Migration[6.1]
  def change
    add_reference :hotel_plan_options, :hotel_meal, foreign_key: true
    add_column :hotel_plan_options, :start_date_stay, :date
    add_column :hotel_plan_options, :end_date_stay, :date
    add_column :hotel_plan_options, :room_ids, :string, array: true, default: []
  end
end
