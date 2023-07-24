# frozen_string_literal: true

class Admin::PermissionOperations::BranchOperations::Create < ApplicationOperation
  def call
    PermissionContracts::CompanyBranchContracts::Create.new(company_branch_params).valid!
    CompanyBranch.create!(company_branch_params)
  end

  def company_branch_params
    params.permit(:name)
  end
end
