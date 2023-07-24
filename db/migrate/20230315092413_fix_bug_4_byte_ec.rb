class FixBug4ByteEc < ActiveRecord::Migration[6.1]
  def change
    change_column :products, :desired_delivery_date, :bigint
  end
end
