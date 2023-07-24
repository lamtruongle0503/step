# frozen_string_literal: true

class Admin::PermissionOperations::StaffOperations::Index < ApplicationOperation
  def call
    authorize nil, Permissions::StaffPolicy

    @q = CompanyStaff.includes(:company_department, :company_branch).ransack(params[:q])
    @q.result(distinct: true).newest.page(params[:page])
  end
end
