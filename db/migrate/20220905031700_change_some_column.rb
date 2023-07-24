class ChangeSomeColumn < ActiveRecord::Migration[6.1]
  def change
    change_column :hotels, :room_total, :bigint

    change_column :hotel_children_infos, :fee, :bigint, default: 0

    change_column :hotel_cancellation_details, :flg1, :bigint
    change_column :hotel_cancellation_details, :flg2, :bigint

    change_column :hotel_rooms, :square_meter_max, :float
    change_column :hotel_rooms, :square_meter_min, :float
    change_column :hotel_rooms, :total_floor_max, :bigint

    change_column :tour_cancellation_details, :flg1, :bigint
    change_column :tour_cancellation_details, :flg2, :bigint
  end
end
