class AddColumnDescriptionsToTours < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :options, :string
    add_column :tours, :sight_seeing, :string
    add_column :tours, :scheduler, :string
    add_column :tours, :note, :string
  end
end
