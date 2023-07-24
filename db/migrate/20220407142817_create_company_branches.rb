class CreateCompanyBranches < ActiveRecord::Migration[6.1]
  def change
    create_table :company_branches do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
