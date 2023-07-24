# frozen_string_literal: true

class Admin::PermissionOperations::DepartmentOperations::Update < ApplicationOperation
  attr_reader :company_department

  def initialize(actor, params)
    super
    @company_department = CompanyDepartment.find(params[:id])
  end

  def call
    PermissionContracts::CompanyDepartmentContracts::Update.new(company_department_params).valid!
    company_department.update!(company_department_params)
  end

  def company_department_params
    params.permit(:name)
  end
end
