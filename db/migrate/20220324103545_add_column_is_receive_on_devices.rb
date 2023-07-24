class AddColumnIsReceiveOnDevices < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :is_receive, :boolean, default: true
  end
end
