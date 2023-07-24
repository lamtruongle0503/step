class CreateTourManagementFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :tour_management_files do |t|
      t.string :bus_no
      t.string :departure_location
      t.integer :number_of_people
      t.string :capacity

      t.timestamps
    end
  end
end
