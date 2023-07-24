# frozen_string_literal: true

class Admin::PermissionOperations::DepartmentOperations::Destroy < ApplicationOperation
  attr_reader :company_department

  def initialize(actor, params)
    super
    @company_department = CompanyDepartment.find(params[:id])
  end

  def call
    @company_department.destroy!
  end
end
