class AddColumnPointUsageExp < ActiveRecord::Migration[6.1]
  def change
    add_column :point_usages, :exp_start_date, :date
    add_column :point_usages, :exp_end_date, :date
  end
end
