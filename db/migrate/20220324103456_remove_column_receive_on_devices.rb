class RemoveColumnReceiveOnDevices < ActiveRecord::Migration[6.1]
  def change
    remove_column :devices, :is_receive
  end
end
