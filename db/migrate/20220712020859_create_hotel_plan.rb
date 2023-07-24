class CreateHotelPlan < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_plans do |t|
      t.belongs_to :hotel_id, foriegn_key: true, index: true
      t.string :management_name
      t.string :name
      t.integer :type_plan, default: 0
      t.integer :type_meal, default: 0
      t.integer :setting_show, default: 0
      t.jsonb :payments
      t.string :setting_payments
      t.date :start_stay_date
      t.date :end_stay_date
      t.string :setting_limit
      t.string :setting_number_night_stay
      t.string :setting_limit_room
      t.string :setting_sale_off
      t.string :setting_check_in
      t.string :setting_check_out
      t.boolean :setting_children, default: false
      t.integer :hotel_meal_id
      t.belongs_to :hotel_cancellation_policy, foriegn_key: true, index: true
      t.boolean :is_use_coupon, default: false
      t.integer :point_receive
      t.integer :exp_point_receive
      t.integer :point_bonus
      t.integer :exp_point_bonus, default: 1

      t.timestamps
    end
  end
end
