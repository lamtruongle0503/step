class AddColumnLocationInPrefecture < ActiveRecord::Migration[6.1]
  def change
    add_column :prefectures, :location_area_id, :integer
  end
end
