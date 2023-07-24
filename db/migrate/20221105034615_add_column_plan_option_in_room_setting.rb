class AddColumnPlanOptionInRoomSetting < ActiveRecord::Migration[6.1]
  def change
    add_reference :hotel_room_settings, :hotel_plan_option, foreign_key: true
  end
end
