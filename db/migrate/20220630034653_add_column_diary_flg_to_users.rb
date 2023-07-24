class AddColumnDiaryFlgToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :diary_flg, :boolean, default: false
  end
end
