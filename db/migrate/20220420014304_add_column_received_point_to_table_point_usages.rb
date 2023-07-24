class AddColumnReceivedPointToTablePointUsages < ActiveRecord::Migration[6.1]
  def change
    add_column :point_usages, :received_point, :float
    change_column :point_usages, :used_point, :float
  end
end
