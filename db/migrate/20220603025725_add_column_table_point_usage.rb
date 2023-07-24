class AddColumnTablePointUsage < ActiveRecord::Migration[6.1]
  def change
    add_column :point_usages, :type_point, :integer, default: 0
    add_column :point_usages, :title, :string
    add_column :point_usages, :description, :string
    add_column :point_usages, :start_date, :datetime
    add_column :point_usages, :end_date, :datetime
    add_column :point_usages, :is_received, :boolean, default: false
  end
end
