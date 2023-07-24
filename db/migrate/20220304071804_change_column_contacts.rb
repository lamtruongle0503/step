class ChangeColumnContacts < ActiveRecord::Migration[6.1]
  def change
    remove_column :contacts, :user_id
    add_column :contacts, :user, :string
  end
end
