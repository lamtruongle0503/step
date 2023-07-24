class AddColumnCancellationSettingIdToTours < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :tour_cancellation_policy_id, :integer, foreign_key: true
  end
end
