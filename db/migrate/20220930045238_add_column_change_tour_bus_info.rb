class AddColumnChangeTourBusInfo < ActiveRecord::Migration[6.1]
  def change
    change_column(:tour_bus_infos, :bus_no, :string)
  end
end
