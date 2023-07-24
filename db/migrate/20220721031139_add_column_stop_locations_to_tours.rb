class AddColumnStopLocationsToTours < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :stop_locations, :string
  end
end
