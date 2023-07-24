class ChangeTypeSomeColumnHotelPlanAndCancellationPolicy < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_cancellation_policies, :hotel_cancellation_detail_id
    remove_column :hotel_plans, :hotel_id_id
    add_reference :hotel_plans, :hotel, foreign_key: true
  end
end
