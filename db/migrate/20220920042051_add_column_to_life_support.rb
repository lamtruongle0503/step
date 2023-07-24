class AddColumnToLifeSupport < ActiveRecord::Migration[6.1]
  def change
    add_column :life_supports, :company_name, :string
    add_column :life_supports, :email, :string
  end
end
