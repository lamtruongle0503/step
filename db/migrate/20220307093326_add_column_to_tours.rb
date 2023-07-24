class AddColumnToTours < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :start_time, :date
    add_column :tours, :end_time, :date
  end
end
