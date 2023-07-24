class AddStaffPasswordToTableCompanyStaff < ActiveRecord::Migration[6.1]
  def change
    add_column :company_staffs, :staff_password, :string
  end
end
