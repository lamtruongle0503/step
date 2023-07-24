class AddColumnPointBonusToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :point_bonus, :integer, default: 0
  end
end
