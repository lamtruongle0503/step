class AddColumnCheckoutDateToTableOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :checkout_date, :datetime
  end
end
