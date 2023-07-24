class AddColumnToTourSpecialFoods < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_special_foods, :code, :string
  end
end
