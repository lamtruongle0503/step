class AddColumnHotelChildreninfo < ActiveRecord::Migration[6.1]
  def change
    add_column :hotel_children_infos, :code, :string
    rename_column :hotel_children_infos, :type_info, :name
  end
end
