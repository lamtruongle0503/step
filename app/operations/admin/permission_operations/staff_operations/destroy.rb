# frozen_string_literal: true

class Admin::PermissionOperations::StaffOperations::Destroy < ApplicationOperation
  attr_reader :company_staff

  def initialize(actor, params)
    super
    @company_staff = CompanyStaff.find(params[:id])
  end

  def call
    authorize nil, Permissions::StaffPolicy

    @company_staff.destroy!
  end
end
