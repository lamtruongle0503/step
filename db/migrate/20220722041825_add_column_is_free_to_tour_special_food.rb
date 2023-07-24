class AddColumnIsFreeToTourSpecialFood < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_special_foods, :is_free, :boolean, default: false
  end
end
