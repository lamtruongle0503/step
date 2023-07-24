class ChangeTypeIntegerToBigInt < ActiveRecord::Migration[6.1]
  def change
    change_column :hotel_cancellation_policies, :date_free_cancellation, :bigint
  end
end
