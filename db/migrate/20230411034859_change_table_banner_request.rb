class ChangeTableBannerRequest < ActiveRecord::Migration[6.1]
  def change
    change_column :banner_requests, :user_id, :bigint, null: true
  end
end
