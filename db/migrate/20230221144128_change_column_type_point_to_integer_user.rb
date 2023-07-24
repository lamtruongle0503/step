class ChangeColumnTypePointToIntegerUser < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :point, :bigint, default: 0
  end

  def down
    change_column :users, :point, :float, default: 0
  end
end
