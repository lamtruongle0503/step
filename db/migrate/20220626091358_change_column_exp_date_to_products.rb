class ChangeColumnExpDateToProducts < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :exp_date, :string
  end
end
