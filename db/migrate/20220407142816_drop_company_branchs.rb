class DropCompanyBranchs < ActiveRecord::Migration[6.1]
  def change
    drop_table :company_branchs
  end
end
