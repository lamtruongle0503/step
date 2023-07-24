class AddIsVerifyToTableUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_verify, :boolean, default: false
  end
end
