# frozen_string_literal: true

class Admin::PermissionOperations::StaffOperations::Create < ApplicationOperation
  def call
    authorize nil, Permissions::StaffPolicy

    PermissionContracts::CompanyStaffContracts::Create.new(staff_params).valid!
    CompanyStaff.create!(staff_params)
  end

  private

  def staff_params
    params.permit(:email, :password, :name, :company_branch_id, :company_department_id)
          .merge(staff_password: params[:password])
  end
end
