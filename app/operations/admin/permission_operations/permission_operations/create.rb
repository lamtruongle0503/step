# frozen_string_literal: true

class Admin::PermissionOperations::PermissionOperations::Create < ApplicationOperation
  attr_reader :department, :permissions

  def initialize(actor, params)
    super
    @department = CompanyDepartment.find(params[:company_department_id])
    @permissions = Permission.where(id: params[:permission_ids])
  end

  def call
    authorize Permission

    permissions.each do |permission|
      department.departments_permissions.create!(permission: permission)
    end
  end
end
