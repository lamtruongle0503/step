# frozen_string_literal: true

class Admin::PermissionOperations::BranchOperations::Index < ApplicationOperation
  def call
    @q = CompanyBranch.ransack(params[:q])
    @q.result(distinct: true).page(params[:page])
  end
end
