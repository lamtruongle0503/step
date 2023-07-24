class AddColumnToTour < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :info_travel_fee, :string
  end
end
