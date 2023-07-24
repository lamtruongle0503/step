class AddStatusToLifeSupportRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :life_support_requests, :status, :integer, default: 0
  end
end
