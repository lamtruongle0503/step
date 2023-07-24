class ChangeColumnTours < ActiveRecord::Migration[6.1]
  def change
    change_column :tours, :end_date, :date
    change_column :tours, :start_date, :date
  end
end
