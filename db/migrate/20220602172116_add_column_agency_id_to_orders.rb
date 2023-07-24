class AddColumnAgencyIdToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :agency_id, :integer
  end
end
