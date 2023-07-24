class CreateHotelPlanChildrens < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_plan_children do |t|
      t.belongs_to :hotel_plan, foreign_key: true
      t.belongs_to :hotel_children_info, foreign_key: true

      t.timestamps
    end
  end
end
