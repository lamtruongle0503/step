# frozen_string_literal: true

class Api::BannerOperations::RequestOperations::Create < ApplicationOperation
  attr_reader :banner, :request

  def initialize(actor, params)
    super
    @banner = Banner.find(params[:banner_id])
  end

  def call
    valid_request!
    @request = create_request!
    send_mail_to_admin!
  end

  private

  def valid_request!
    BannerContracts::RequestContracts::Create.new(request_params).valid!
  end

  def create_request!
    Banner::Request.create(request_params.merge(banner_id: banner.id, user_id: actor&.id))
  end

  def send_mail_to_admin!
    client = AwsSqsService.new

    title = '【STEP TRAVEL 通販サービス】請求する資料のメール'
    body = BannerMailer.with(request: request).notify_to_admin.body.to_s.html_safe

    client.send('EMAIL', title, body, banner.email)
  end

  def request_params
    params.permit(:name, :postal_code, :address1, :address2, :phone_number)
  end
end
