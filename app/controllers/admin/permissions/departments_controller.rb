# frozen_string_literal: true

class Admin::Permissions::DepartmentsController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Admin::PermissionOperations::DepartmentOperations::Create.new(actor, params).call,
           serializer: Admin::Permissions::Departments::CreateSerializer, root: 'permissions'
  end

  def index
    company_departments = Admin::PermissionOperations::DepartmentOperations::Index.new(actor, params).call
    render json: company_departments,
           each_serializer: Admin::Permissions::Departments::IndexSerializer,
           meta: pagination_dict(company_departments), root: 'data', adapter: :json
  end

  def update
    render json: Admin::PermissionOperations::DepartmentOperations::Update.new(actor, params).call,
           serializer: Admin::Permissions::Departments::UpdateSerializer, root: 'permissions'
  end

  def destroy
    render json: Admin::PermissionOperations::DepartmentOperations::Destroy.new(actor, params).call,
           serializer: Admin::Permissions::Departments::DestroySerializer, root: 'permissions'
  end
end
