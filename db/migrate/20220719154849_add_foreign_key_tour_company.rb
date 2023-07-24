class AddForeignKeyTourCompany < ActiveRecord::Migration[6.1]
  def change
    remove_column :tours, :tour_company_id
    add_reference :tours, :tour_company
  end
end
