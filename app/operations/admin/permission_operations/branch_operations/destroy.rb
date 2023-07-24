# frozen_string_literal: true

class Admin::PermissionOperations::BranchOperations::Destroy < ApplicationOperation
  attr_reader :company_branch

  def initialize(actor, params)
    super
    @company_branch = CompanyBranch.find(params[:id])
  end

  def call
    @company_branch.destroy!
  end
end
