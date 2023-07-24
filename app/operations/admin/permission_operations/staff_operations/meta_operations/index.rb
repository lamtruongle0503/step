# frozen_string_literal: true

class Admin::PermissionOperations::StaffOperations::MetaOperations::Index < ApplicationOperation
  def call
    @q = CompanyStaff.ransack(params[:q])
    @q.result(distinct: true).newest
  end
end
