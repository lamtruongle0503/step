class ChangeModelAgency < ActiveRecord::Migration[6.1]
  def change
    add_column :agencies, :company_name, :string
  end
end
