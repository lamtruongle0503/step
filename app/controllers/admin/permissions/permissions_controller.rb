# frozen_string_literal: true

class Admin::Permissions::PermissionsController < ApiV1Controller
  before_action :authentication!

  def index
    permissions = Admin::PermissionOperations::PermissionOperations::Index.new(actor, params).call
    render json: permissions,
           serializer: Admin::Permissions::Permissions::IndexSerializer, root: 'permissions'
  end

  def create
    render json: Admin::PermissionOperations::PermissionOperations::Create.new(actor, params).call,
           serializer: Admin::Permissions::Permissions::CreateSerializer, root: 'permissions'
  end

  def destroy
    render json: Admin::PermissionOperations::PermissionOperations::Destroy.new(actor, params).call,
           serializer: Admin::Permissions::Permissions::DestroySerializer, root: 'permissions'
  end
end
