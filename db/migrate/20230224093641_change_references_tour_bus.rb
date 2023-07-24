class ChangeReferencesTourBus < ActiveRecord::Migration[6.1]
  def change
    add_reference :tour_bus_infos, :tour_place_start
  end
end
