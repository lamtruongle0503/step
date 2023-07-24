# frozen_string_literal: true

class Api::LifeSupportOperations::RequestOperations::Create < ApplicationOperation
  attr_reader :life_support, :request

  def initialize(actor, params)
    super
    @life_support = LifeSupport.find(params[:life_support_id])
  end

  def call
    valid_request!
    @request = create_request!
    send_mail_to_admin!
  end

  private

  def valid_request!
    LifeSupportContracts::RequestContracts::Create.new(request_params).valid!
  end

  def create_request!
    LifeSupport::Request.create(request_params.merge(life_support_id: life_support.id, user_id: actor&.id))
  end

  def send_mail_to_admin!
    client = AwsSqsService.new

    title = '【STEP TRAVEL 通販サービス】請求する資料のメール'
    body = LifeSupportMailer.with(request: request).notify_to_admin.body.to_s.html_safe

    client.send('EMAIL', title, body, life_support.email)
  end

  def request_params
    params.permit(:name, :postal_code, :address1, :address2, :phone_number)
  end
end
