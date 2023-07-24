class CreateHotelChildrenInfos < ActiveRecord::Migration[6.1]
  def change
    create_table :hotel_children_infos do |t|
      t.belongs_to :hotel, foreign_key: true
      t.integer :type_info, default: 0
      t.boolean :is_accept, default: false
      t.integer :fee, default: 0
      t.integer :unit, defaule: 0
      t.integer :capacity

      t.timestamps  
    end
  end
end
