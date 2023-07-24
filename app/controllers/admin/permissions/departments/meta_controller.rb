# frozen_string_literal: true

class Admin::Permissions::Departments::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    company_departments = Admin::PermissionOperations::DepartmentOperations::MetaOperations::Index.new(
      actor, params
    ).call
    render json:            company_departments,
           each_serializer: Admin::Permissions::Departments::Meta::IndexSerializer
  end
end
