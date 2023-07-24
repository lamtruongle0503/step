# frozen_string_literal: true

class Admin::PermissionOperations::DepartmentOperations::Index < ApplicationOperation
  def call
    @q = CompanyDepartment.ransack(params[:q])
    @q.result(distinct: true).page(params[:page])
  end
end
