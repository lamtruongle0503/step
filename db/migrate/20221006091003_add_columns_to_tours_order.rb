class AddColumnsToToursOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :tour_orders, :date_of_cancellation_fee, :date
  end
end
