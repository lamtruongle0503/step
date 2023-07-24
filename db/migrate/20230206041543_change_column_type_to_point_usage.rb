class ChangeColumnTypeToPointUsage < ActiveRecord::Migration[6.1]
  def change
    change_column :point_usages, :start_date, :date
    change_column :point_usages, :end_date, :date
  end
end
