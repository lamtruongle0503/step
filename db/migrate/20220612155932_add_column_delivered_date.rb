class AddColumnDeliveredDate < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :delivered_date, :date
  end
end
