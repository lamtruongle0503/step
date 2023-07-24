# frozen_string_literal: true

class Admin::PermissionOperations::BranchOperations::Update < ApplicationOperation
  attr_reader :company_branch

  def initialize(actor, params)
    super
    @company_branch = CompanyBranch.find(params[:id])
  end

  def call
    PermissionContracts::CompanyBranchContracts::Update.new(company_branch_params).valid!
    company_branch.update!(company_branch_params)
  end

  def company_branch_params
    params.permit(:name)
  end
end
