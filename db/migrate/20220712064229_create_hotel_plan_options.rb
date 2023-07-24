class CreateHotelPlanOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_plan_options do |t|
      t.belongs_to :hotel_plan, foreign_key: true
      t.belongs_to :hotel_option, foreign_key: true

      t.timestamps
    end
  end
end
