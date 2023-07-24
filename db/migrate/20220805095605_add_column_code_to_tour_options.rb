class AddColumnCodeToTourOptions < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_options, :code, :string
  end
end
