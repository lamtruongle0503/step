class AddSomeColumnToTableProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :is_limit, :boolean, default: :false
    add_column :products, :exp_date, :datetime
  end
end
