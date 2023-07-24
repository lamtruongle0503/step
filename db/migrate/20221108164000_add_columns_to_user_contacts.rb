class AddColumnsToUserContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :user_contacts, :full_name, :string
    add_column :user_contacts, :furigana, :string
  end
end
