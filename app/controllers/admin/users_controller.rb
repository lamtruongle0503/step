# frozen_string_literal: true

class Admin::UsersController < ApiV1Controller
  before_action :authentication!

  # GET /users
  def index
    users = Admin::UserOperations::Index.new(actor, params).call
    render json: users, each_serializer: Admin::Users::IndexSerializer,
           meta: pagination_dict(users), root: 'data', adapter: :json
  end

  # GET /users/:id
  def show
    render json:       Admin::UserOperations::Show.new(actor, params).call,
           serializer: Admin::Users::ShowSerializer, root: 'users'
  end

  def update
    render json:       Admin::UserOperations::Update.new(actor, params).call,
           serializer: Admin::Users::UpdateSerializer, root: 'users'
  end

  def destroy
    Admin::UserOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
