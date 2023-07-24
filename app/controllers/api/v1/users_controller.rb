# frozen_string_literal: true

class Api::V1::UsersController < ApiV1Controller
  before_action :authentication!, except: %i[create verify resend_otp]

  # GET /users
  def index
    render json:            Api::UserOperations::Index.new(actor, params).call,
           each_serializer: Users::IndexSerializer
  end

  # GET /users/:id
  def show
    render json:       Api::UserOperations::Show.new(actor, params).call,
           serializer: Users::ShowSerializer, root: 'users'
  end

  # POST /users
  def create
    user = Api::UserOperations::Create.new(nil, params).call
    render json: user, serializer: Users::CreateSerializer
  end

  # PATCH/PUT /users/1
  def update
    render json:       Api::UserOperations::Update.new(actor, params).call,
           serializer: Users::ShowSerializer, root: 'users'
  end

  def verify
    render json: Api::UserOperations::Verify.new(nil, params).call
  end

  def resend_otp
    Api::UserOperations::ResendOtp.new(nil, params).call
    render json: {}
  end
end
