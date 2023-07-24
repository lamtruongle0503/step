class AddColumnToAdminSettings < ActiveRecord::Migration[6.1]
  def change
    add_column :admin_settings, :password_digest, :string
  end
end
