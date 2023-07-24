# frozen_string_literal: true

class Admin::PermissionOperations::DepartmentOperations::MetaOperations::Index < ApplicationOperation
  def call
    CompanyDepartment.all
  end
end
