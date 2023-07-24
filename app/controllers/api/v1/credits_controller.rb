# frozen_string_literal: true

class Api::V1::CreditsController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Api::CreditOperations::Create.new(actor, params).call,
           serializer: Api::Credits::CreateSerializer, root: 'credits'
  end

  def update
    render json: Api::CreditOperations::Update.new(actor, params).call,
           serializer: Api::Credits::CreateSerializer, root: 'credits'
  end

  def destroy
    render json: Api::CreditOperations::Destroy.new(actor, params).call,
           serializer: Api::Credits::DestroySerializer, root: 'credits'
  end
end
