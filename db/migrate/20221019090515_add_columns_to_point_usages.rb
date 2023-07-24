class AddColumnsToPointUsages < ActiveRecord::Migration[6.1]
  def change
    add_column :point_usages, :status, :integer, :default => 0
  end
end
