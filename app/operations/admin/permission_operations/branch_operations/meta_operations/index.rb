# frozen_string_literal: true

class Admin::PermissionOperations::BranchOperations::MetaOperations::Index < ApplicationOperation
  def call
    CompanyBranch.all
  end
end
