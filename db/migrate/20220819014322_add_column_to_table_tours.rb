class AddColumnToTableTours < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :plan_implement, :string
    add_column :tours, :transport_used, :string
  end
end
