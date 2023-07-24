class AddColumnDeliveryStartTimeToOrderInfo < ActiveRecord::Migration[6.1]
  def change
    remove_column :order_infos, :delivery_time
    add_column :order_infos, :delivery_start_time, :time
    add_column :order_infos, :delivery_end_time, :time
  end
end
