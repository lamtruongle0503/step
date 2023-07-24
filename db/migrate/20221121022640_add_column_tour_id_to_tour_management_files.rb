class AddColumnTourIdToTourManagementFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_management_files, :tour_id, :integer
  end
end
