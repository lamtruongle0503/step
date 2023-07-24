# frozen_string_literal: true

class Admin::PermissionOperations::PermissionOperations::Index < ApplicationOperation
  attr_reader :department

  def initialize(actor, params)
    super
    @department = CompanyDepartment.find(params[:company_department_id])
  end

  def call
    authorize Permission

    permissions = Permission.all
    department_permissions = department.permissions
    { permissions: permissions, department_permissions: department_permissions }
  end
end
