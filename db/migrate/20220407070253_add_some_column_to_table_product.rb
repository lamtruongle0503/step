class AddSomeColumnToTableProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :is_desired_date_free, :boolean, default: false
    add_column :products, :is_desired_time_free, :boolean, default: false
  end
end
