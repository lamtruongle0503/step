# frozen_string_literal: true

class Api::V1::Users::AddressesController < ApiV1Controller
  before_action :authentication!

  def index
    render json:            Api::UserOperations::AddressOperations::Index
      .new(actor, params).call,
           each_serializer: Api::Users::Addresses::IndexSerializer
  end

  def create
    render json:       Api::UserOperations::AddressOperations::Create
      .new(actor, params).call,
           serializer: Api::Users::Addresses::CreateSerializer
  end

  def update
    render json:       Api::UserOperations::AddressOperations::Update
      .new(actor, params).call,
           serializer: Api::Users::Addresses::UpdateSerializer
  end

  def destroy
    Api::UserOperations::AddressOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
