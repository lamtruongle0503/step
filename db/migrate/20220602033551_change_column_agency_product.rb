class ChangeColumnAgencyProduct < ActiveRecord::Migration[6.1]
  def change
    change_column :agencies, :fee_shipping, :bigint
    change_column :products, :tax, :integer, default: 10
    add_column :products, :point_bonus, :integer
    add_column :products, :point_start_date, :date
    add_column :products, :point_end_date, :date
  end
end
