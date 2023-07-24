class ChangeColumnExpDateProducts < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :exp_date, :date
  end
end
