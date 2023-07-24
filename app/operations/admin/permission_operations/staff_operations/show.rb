# frozen_string_literal: true

class Admin::PermissionOperations::StaffOperations::Show < ApplicationOperation
  def call
    authorize nil, Permissions::StaffPolicy

    CompanyStaff.find(params[:id])
  end
end
