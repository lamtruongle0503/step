# frozen_string_literal: true

class Admin::Permissions::Branches::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    company_branches = Admin::PermissionOperations::BranchOperations::MetaOperations::Index.new(actor,
                                                                                                params).call
    render json:            company_branches,
           each_serializer: Admin::Permissions::Branches::Meta::IndexSerializer
  end
end
