# frozen_string_literal: true

class Admin::Permissions::StaffsController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Admin::PermissionOperations::StaffOperations::Create.new(actor, params).call,
           serializer: Admin::Permissions::Staffs::CreateSerializer, root: 'permissions'
  end

  def index
    company_staffs = Admin::PermissionOperations::StaffOperations::Index.new(actor, params).call
    render json: company_staffs,
           each_serializer: Admin::Permissions::Staffs::IndexSerializer,
           meta: pagination_dict(company_staffs), root: 'data', adapter: :json
  end

  def update
    render json: Admin::PermissionOperations::StaffOperations::Update.new(actor, params).call,
           serializer: Admin::Permissions::Staffs::UpdateSerializer, root: 'permissions'
  end

  def destroy
    render json: Admin::PermissionOperations::StaffOperations::Destroy.new(actor, params).call,
           serializer: Admin::Permissions::Staffs::DestroySerializer, root: 'permissions'
  end

  def show
    render json: Admin::PermissionOperations::StaffOperations::Show.new(actor, params).call,
           serializer: Admin::Permissions::Staffs::ShowSerializer, root: 'permissions'
  end
end
