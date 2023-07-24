class AddColumnsToTourSpecialFoodAndTourOption < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_special_foods, :deleted_at, :datetime
    add_column :tour_options, :deleted_at, :datetime
  end
end
