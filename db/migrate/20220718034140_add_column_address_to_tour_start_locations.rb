class AddColumnAddressToTourStartLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_start_locations, :address, :string
  end
end
