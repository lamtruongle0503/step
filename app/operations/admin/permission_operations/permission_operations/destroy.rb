# frozen_string_literal: true

class Admin::PermissionOperations::PermissionOperations::Destroy < ApplicationOperation
  def call
    authorize Permission

    department_permissions = DepartmentsPermission.where(
      company_department_id: params[:company_department_id],
      permission_id:         params[:permission_ids],
    )
    department_permissions&.destroy_all
  end
end
