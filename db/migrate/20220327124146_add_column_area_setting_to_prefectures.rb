class AddColumnAreaSettingToPrefectures < ActiveRecord::Migration[6.1]
  def change
    add_reference :prefectures, :area_setting, foreign_key: true 
  end
end
