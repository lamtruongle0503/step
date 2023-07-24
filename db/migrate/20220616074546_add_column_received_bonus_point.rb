class AddColumnReceivedBonusPoint < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :received_bonus_point, :float
  end
end
