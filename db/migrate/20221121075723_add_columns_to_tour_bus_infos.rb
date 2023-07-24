class AddColumnsToTourBusInfos < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_bus_infos, :operation_status, :string
  end
end
