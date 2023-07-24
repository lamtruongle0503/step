class ChangeTableLifeSupportRequest < ActiveRecord::Migration[6.1]
  def change
    change_column :life_support_requests, :user_id, :bigint, null: true
  end
end
