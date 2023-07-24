# frozen_string_literal: true

class Admin::Permissions::Staffs::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    permissions = Admin::PermissionOperations::StaffOperations::MetaOperations::Index.new(
      actor, params
    ).call
    render json:            permissions,
           each_serializer: Admin::Permissions::Staffs::Meta::IndexSerializer
  end
end
