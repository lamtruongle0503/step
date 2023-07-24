# frozen_string_literal: true

class Admin::Permissions::Staffs::PermissionsController < ApiV1Controller
  before_action :authentication!

  def index
    permissions = Admin::PermissionOperations::StaffOperations::PermissionOperations::Index.new(
      actor, params
    ).call
    render json:            permissions,
           each_serializer: Admin::Permissions::Staffs::Permissions::IndexSerializer
  end
end
