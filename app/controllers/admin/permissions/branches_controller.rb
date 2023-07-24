# frozen_string_literal: true

class Admin::Permissions::BranchesController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Admin::PermissionOperations::BranchOperations::Create.new(actor, params).call,
           serializer: Admin::Permissions::Branches::CreateSerializer, root: 'permissions'
  end

  def index
    company_branches = Admin::PermissionOperations::BranchOperations::Index.new(actor, params).call
    render json: company_branches,
           each_serializer: Admin::Permissions::Branches::IndexSerializer,
           meta: pagination_dict(company_branches), root: 'data', adapter: :json
  end

  def update
    render json: Admin::PermissionOperations::BranchOperations::Update.new(actor, params).call,
           serializer: Admin::Permissions::Branches::UpdateSerializer, root: 'permissions'
  end

  def destroy
    render json: Admin::PermissionOperations::BranchOperations::Destroy.new(actor, params).call,
           serializer: Admin::Permissions::Branches::DestroySerializer, root: 'permissions'
  end
end
