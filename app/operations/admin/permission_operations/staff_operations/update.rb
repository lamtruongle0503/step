# frozen_string_literal: true

class Admin::PermissionOperations::StaffOperations::Update < ApplicationOperation
  attr_reader :company_staff

  def initialize(actor, params)
    super
    @company_staff = CompanyStaff.find(params[:id])
  end

  def call
    authorize nil, Permissions::StaffPolicy

    PermissionContracts::CompanyStaffContracts::Update.new(staff_params.merge(record: company_staff)).valid!
    company_staff.update!(staff_params)
  end

  def staff_params
    params.permit(:email, :password, :name, :company_branch_id, :company_department_id)
          .merge(staff_password: params[:password])
  end
end
