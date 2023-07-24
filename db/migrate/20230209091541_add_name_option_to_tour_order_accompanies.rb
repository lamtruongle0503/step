class AddNameOptionToTourOrderAccompanies < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_order_accompanies, :name_option, :jsonb
  end
end
