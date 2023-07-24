# frozen_string_literal: true

class Admin::PermissionOperations::StaffOperations::PermissionOperations::Index < ApplicationOperation
  def call
    return Permission.all if actor.is_a? Admin

    actor.permissions
  end
end
