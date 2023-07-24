class ChangeColumnIsDmUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :is_dm, :boolean, default: true
  end
end
