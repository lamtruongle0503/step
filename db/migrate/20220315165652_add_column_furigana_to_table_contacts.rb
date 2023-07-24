class AddColumnFuriganaToTableContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :furigana, :string
  end
end
