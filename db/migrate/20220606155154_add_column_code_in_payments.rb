class AddColumnCodeInPayments < ActiveRecord::Migration[6.1]
  def change
    add_column :payments, :code, :string
  end
end
