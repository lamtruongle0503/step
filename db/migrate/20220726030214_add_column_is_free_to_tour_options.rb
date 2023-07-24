class AddColumnIsFreeToTourOptions < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_options, :is_free, :boolean, default: false
  end
end
