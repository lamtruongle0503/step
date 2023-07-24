class AddColumnTourCompanyToTours < ActiveRecord::Migration[6.1]
  def change
    add_column :tours, :tour_company_id, :integer, foreign_key: true
  end
end
