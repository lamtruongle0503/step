class CreateCompanyStaff < ActiveRecord::Migration[6.1]
  def change
    create_table :company_staffs do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.belongs_to :company_branch, foreign_key: true
      t.belongs_to :company_department, foreign_key: true

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
