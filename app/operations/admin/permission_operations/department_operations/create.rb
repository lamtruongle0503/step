# frozen_string_literal: true

class Admin::PermissionOperations::DepartmentOperations::Create < ApplicationOperation
  def call
    PermissionContracts::CompanyDepartmentContracts::Create.new(company_department_params).valid!
    CompanyDepartment.create!(company_department_params)
  end

  def company_department_params
    params.permit(:name)
  end
end
