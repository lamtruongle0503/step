# frozen_string_literal: true

class Api::V1::Ecommerces::Orders::ReceiptionsController < ApiV1Controller
  before_action :authentication!

  def show
    receiption = Api::EcommerceOperations::OrderOperations::ReceiptionOperations::Show.new(actor, params).call
    render json: receiption,
           serializer: Api::Ecommerces::Orders::Receiptions::ShowSerializer, actor: actor,
           root: 'ecommerces'
  end

  def update
    Api::EcommerceOperations::OrderOperations::ReceiptionOperations::Update.new(actor, params).call
    render json: {}
  end

  def download
    receiption = Api::EcommerceOperations::OrderOperations::ReceiptionOperations::Download.new(actor,
                                                                                               params).call

    send_file receiption
  end
end
