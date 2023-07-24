class ChangeChildrenInfo < ActiveRecord::Migration[6.1]
  def change
    remove_column :hotel_children_infos, :is_accept
    add_column :hotel_children_infos, :is_accept, :integer, default: 0
    remove_column :hotel_children_infos, :type_info
    add_column :hotel_children_infos, :type_info, :string
  end
end
